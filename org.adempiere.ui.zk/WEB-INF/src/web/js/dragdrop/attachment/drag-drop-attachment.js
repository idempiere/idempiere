/*******************************************************************************
 * Copyright (C) 2017 Adaxa Pty Ltd. All Rights Reserved. This program is free
 * software; you can redistribute it and/or modify it under the terms version 2
 * of the GNU General Public License as published by the Free Software
 * Foundation. This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 ******************************************************************************/
/**
 * Drag and Drop functionality for Attachment
 * 
 * @author Logilite Technologies
 * @since October 16, 2017
 */

if (typeof window.idempiere === 'undefined')
	window.idempiere = {};

window.idempiere.dropToAttachFiles = function(formID, dropBtnID, desktopID, progBarID, progLabelID, maxUploadSize) {

	var clsName = " attachment-drag-entered";

	var seqID = 0;
	var highlightdragging;
	var dropBtn = document.getElementById(dropBtnID);
	var progressbar = document.getElementById(progBarID);

	var isSupported = {
		dnd: 'draggable' in document.createElement('span'),
		formdata: !!window.FormData,
		progress: "upload" in new XMLHttpRequest
	};

	if (isSupported.dnd) {
		dropBtn.ondragover = function() {
			return false;
		};

		dropBtn.ondragenter = function(e) {
			highlightdragging = e.target;
			this.className = this.className + clsName;
			return false;
		};

		dropBtn.ondragleave = function(e) {
			if (e.target === highlightdragging)
				this.className = findAndReplace(this.className, clsName, '');
			return false;
		};

		dropBtn.ondrop = function(e) {
			e.preventDefault();

			var requestSize = 0;
			var files = e.dataTransfer.files;
			for (var i = 0; i < files.length; i++) {
				requestSize = requestSize + files[i].size;
			}

			requestSize = Math.round(requestSize / 1024);

			if (maxUploadSize && requestSize > maxUploadSize) {
				alert('The request was rejected because its size (' + requestSize + ') exceeds the configured maximum (' + maxUploadSize + ')');
				return;
			}

			progressbar.style = 'display: block';
			progressbar.parentNode.style = 'display: block';
			progressBarUploadStatus(progBarID, progLabelID, 0, 'Starting Upload...');
			this.className = findAndReplace(this.className, clsName, '');

			uploadFiles(files, seqID++);
			return false;
		};
	} else {
		clsName = "";
		alert("Click to Upload Files");
	} // drop listener

	function uploadFiles(files, sid) {
		var formData = isSupported.formdata ? new FormData() : null;
		if (isSupported.formdata) {
			for (var i = 0; i < files.length; i++) {
				formData.append('file', files[i], files[i].name);
			}
		}

		var xhr = new XMLHttpRequest();
		var url = "/webui/zkau/upload?uuid=" + formID + "&dtid=" + desktopID + "&sid=" + sid + "&native=true";
		if (maxUploadSize)
			url = url + "&maxsize=" + maxUploadSize;

		xhr.open("POST", url, true);

		// Content-Type is automatically determined by the browser.
		// Sets the content type to 'multipart/form-data' and says that the
		// fields are separated by the boundary string like:
		// "Content-Type: multipart/form-data; boundary=---90519140415446"

		xhr.onload = function() {
			disableProgressInfo(100);
		};

		if (isSupported.progress) {
			xhr.upload.onprogress =
				function(event) {
					progressbar.style = 'display: block';
					progressbar.parentNode.style = 'display: block';
					if (event.lengthComputable) {
						var complete = (event.loaded / event.total * 100 | 0);
						var status = 'Uploading ' + complete + '% [ ' + Math.round(event.loaded / 1024) + ' / ' + Math.round(event.total / 1024) + ' KB ]';
						progressBarUploadStatus(progBarID, progLabelID, complete, status);
					}
				};
		}

		xhr.onreadystatechange =
			function() {
				// 4: request finished and response is ready
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var response = xhr.responseText;
						var startIndex = response.indexOf("zul.Upload.sendResult(");
						var endIndex = response.indexOf("zul.Upload.close(");
						var data = response.substring(startIndex, endIndex);
						var arr = data.split(",");

						if (arr.length > 1) {
							var contID = findAndReplace(arr[1].trim(), "'", "");
							var wgt = zk.Widget.$(formID);
							var event = new zk.Event(wgt.desktop, "updateResult", {
								contentId: contID,
								wid: dropBtnID,
								sid: "" + sid
							});

							zAu.send(event);

						} else {
							alert('Ooops! Something went wrong...!!!');
							disableProgressInfo(0);
						}
					} else {
						alert('Something went wrong...!!! \nPlease you can try with clicking to upload button.')
						disableProgressInfo(0);
					}
				}
			};

		xhr.onerror = function(errorType, exception) {
			var msg = '';
			if (xhr.status === 0) {
				msg = 'Connection Lost. Please Verify Network.';
			} else if (xhr.status == 404) {
				msg = 'Requested page not found. [404]';
			} else if (xhr.status == 500) {
				msg = 'Internal Server Error [500].';
			} else if (exception === 'parsererror') {
				msg = 'Requested parse failed.';
			} else if (exception === 'timeout') {
				msg = 'Time out error.';
			} else if (exception === 'abort') {
				msg = 'Request aborted.';
			} else {
				msg = 'Uncaught Error.\n' + xhr.responseText;
			}

			disableProgressInfo(0);
			console.log(errorType + " - " + exception + " - " + msg);
			alert(msg);
		};

		xhr.send(formData);
	} // uploadFiles

	function disableProgressInfo(val) {
		progressBarUploadStatus(progBarID, progLabelID, val, '');
		progressbar.style = 'display: none';
		progressbar.parentNode.style = 'display: none';
	} // disableProgressInfo

	function findAndReplace(str, target, replacement) {
		return str.replace(new RegExp(target, 'g'), replacement);
	} // findAndReplace

	function progressBarUploadStatus(pbID, plID, val, fileStatus) {
		var pbar = zk.Widget.$(pbID);
		pbar.setValue(val);

		var pLabel = zk.Widget.$(plID);
		pLabel.setValue(fileStatus);
	} // progressBarUploadStatus
};
