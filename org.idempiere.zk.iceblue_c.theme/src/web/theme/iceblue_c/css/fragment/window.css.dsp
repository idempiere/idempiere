<%-- z-window customization --%>
div.wc-modal, div.wc-modal-none, div.wc-highlighted, div.wc-highlighted-none {
	background-color: white;
}

.z-window {
	padding: 0px;
}
.z-window.z-window-noborder.z-window-noheader.z-window-embedded,
.z-window.z-window-noborder.z-window-noheader.z-window-embedded .z-window-content {
	height: 100%;
}

.z-window-embedded .z-window-header, 
.z-window-embedded .z-window-content {
	background-image: none;
}

.z-window-overlapped .z-window-content,  .z-window-modal .z-window-content, 
.z-window-highlighted .z-window-content, .z-window-embedded .z-window-content {
	border: none;
}

.z-window-header {
	padding: 4px 6px 4px 9px;
}
.z-window-embedded > .z-window-header {
	border-radius: 0px;
	background-color: transparent;
}
.z-window-overlapped .z-window-header,
.z-window-popup .z-window-header,
.z-window-modal .z-window-header,
.z-window-highlighted .z-window-header
{
	color: #484848;
	font-weight: bold;
}

.z-window-overlapped, .z-window-popup, .z-window-modal, .z-window-highlighted 
{
	margin: 0px;
}

.z-window-modal-shadow, .z-window-overlapped-shadow, .z-window-popup-shadow, .z-window-embedded-shadow, .z-window-highlighted-shadow
{
	border-radius: 0px !important;
}

.z-modal-mask {
	z-index: 1800 !important;
}

<%-- dialog --%>
.embedded-dialog {
	position: absolute;
}
.embedded-dialog .z-window-embedded-header {
	color: #fff;
	font-weight: bold;
}
.embedded-dialog .z-window-embedded
{
	margin: 0px;
}

.popup-dialog .z-window-overlapped .z-window-content, .popup-dialog .z-window-highlighted .z-window-content {
	padding: 0px;
}
.popup-dialog > .z-window-content, .info-panel > .z-window-content {
	padding: 0px;
}
.popup-dialog .dialog-content {
	padding: 8px !important;
	--margin-bottom: 20px !important;
}

.popup-dialog.z-window-overlapped .dialog-footer {
	padding: 12px 15px 8px 15px !important;
}

.popup-dialog.z-window-highlighted .dialog-footer {
	padding: 12px 15px 8px 15px !important;
}
.popup-dialog.z-window.z-window-overlapped.z-window-shadow,
.popup-dialog.z-window.z-window-noborder.z-window-highlighted.z-window-shadow{
	width:600px;
}
@media screen and (max-width: 600px) {
	.popup-dialog.z-window.z-window-overlapped.z-window-shadow,
	.popup-dialog.z-window.z-window-noborder.z-window-highlighted.z-window-shadow{
		width:100%;
	}	
}

.dialog-footer {
	margin-bottom: 0;
	background-color: #F7FAFF;
	border-top: 1px solid transparent;
	-webkit-box-shadow: inset 0 1px 0 #ffffff;
	-moz-box-shadow: inset 0 1px 0 #ffffff;
	box-shadow: inset 0 1px 0 #ffffff;
}

<%-- notification message --%>
.z-notification .z-notification-content {
    width: 400px;
}
.z-notification {
	padding: 3px !important;
}
.z-notification-info .z-notification-left {
  border-right-color: transparent;
}
.z-notification-left + .z-notification-icon {
  left: 12px;
}

<%-- Quick Form Read-only Component --%>
.quickform-readonly .z-textbox-readonly, .quickform-readonly .z-intbox-readonly, .quickform-readonly .z-longbox-readonly, .quickform-readonly .z-doublebox-readonly,
.quickform-readonly .z-decimalbox-readonly, .quickform-readonly .z-datebox-readonly, .quickform-readonly .z-timebox-readonly, .quickform-readonly .editor-input-disd,
.quickform-readonly .z-textbox[readonly], .quickform-readonly .z-intbox[readonly], .quickform-readonly .z-longbox[readonly], .quickform-readonly .z-doublebox[readonly],
.quickform-readonly .z-decimalbox[readonly], .quickform-readonly .z-datebox[readonly], .quickform-readonly .z-timebox[readonly]
{
    color: #252525 !important;
    opacity: .8;
}
<%-- quick entry form --%>
.quick-form.z-window .z-center-body > .z-div {
	border: none; 
	width: 100%; 
	height:99%;
}
.quick-form.z-window .adtab-grid.z-row .z-cell {
	border-top: 2px solid transparent; 
	border-bottom: 2px solid transparent;
}
.quick-form.z-window .adtab-grid.z-row.current-row .z-cell {
	border-top: 2px solid #6f97d2 !important; 
	border-bottom: 2px solid #6f97d2 !important;
}
.quick-form.z-window .z-south-body > .z-div > .z-div {
	height: 20px; 
}
.quick-form.z-window .z-south-body .confirm-panel {
	padding-top: 9px; 
}

<%-- record id editor dialog --%>
.recordid-dialog {
	min-width: 400px;
}
.recordid-dialog-content {
	display: flex;
	padding: 10px;
}
.recordid-dialog-labels {
	display: grid;
    text-align: right;
    align-items: center;
}
.recordid-dialog-fields {
	display: grid;
	width: 77%;
}
.recordid-dialog-fields .editor-button {
	top: 8px !important;
}
.recordid-dialog-content .z-combobox, .recordid-dialog-content .z-textbox {
	width: 98% !important;
	margin: 8px 5px;
}
.recordid-dialog-confirm {
	text-align: end;
    padding: 10px;
}
.recordid-dialog-confirm .z-button {
	margin: 0px 5px !important;
	height: 30px;
	padding: 0px 10px;
}

.attachment-dialog .z-north {
	padding: 8px;
}
