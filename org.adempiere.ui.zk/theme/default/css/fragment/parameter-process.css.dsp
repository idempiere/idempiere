/* .z-window.z-window-noborder.z-window-noheader.z-window-embedded
.z-window.z-window-noborder.z-window-noheader.z-window-embedded .z-window-content
twwo css make height of window always 100% its parent,
it fix some issue relate resize, but can make side effect
when detect side effect, fix to only apply for parameter window*/
.z-window.z-window-noborder.z-window-noheader.z-window-embedded,
.z-window.z-window-noborder.z-window-noheader.z-window-embedded .z-window-content,
.main-parameter-layout {
	height: 100%;
}
.process-modal-dialog .main-parameter-layout{
	height: auto;
	flex-basis: auto;
}
.process-modal-dialog.z-window > .z-window-content {
	flex: 1 1 auto;
}

.main-parameter-layout,
.top-parameter-layout,
.bottom-parameter-layout,
.message-parameter-layout,
.input-paramenter-layout,
.option-paramenter-layout,
.report-option-container,
.bottom-container{
	width: 100%;
}

.report-option-container {
	overflow-x: auto;
}
.top-parameter-layout{
	overflow: auto;
	padding-bottom: 2vh;
	flex-basis: auto;
}

.bottom-parameter-layout{
	padding: 4px 4px 0px 4px;
	border-top: 1px solid rgba(0, 0, 0, 0.2);
}

.message-paramenter{
	max-height: 300pt; 
	overflow: hidden; 
	margin: 10px;
	line-height: normal;
}

.option-input-parameter{
	
}

.bottom-container{
	overflow: hidden;
}

.button-container{
	float: right;
	overflow: hidden;
	padding: 4px;
}

.save-parameter-container{
	overflow-x: auto;
	overflow-y: hidden;
}

.result-parameter-layout {
	overflow: auto;
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

.input-paramenter-layout{
	width: 70%;
}
@media screen and (max-width: 700px) {
	.input-paramenter-layout{
		width: 90% !important;
	}
}
@media screen and (max-width: 500px) {
	.input-paramenter-layout{
		width: 100% !important;
	}
}

.popup-dialog .input-paramenter-layout{
	width: 90%;
}

@media screen and (max-width: 500px) {
	.option-input-parameter.z-label.print-format-label,
	.option-input-parameter.z-label.view-report-label {
		display: none;
	}		
}
@media screen and (min-width: 501px) {
	.option-input-parameter.print-format-list > input::-webkit-input-placeholder {
		color: white;
	}
}
@media screen and (min-width: 501px) {
	.option-input-parameter.print-format-list > input::-moz-placeholder {
		color: white;
	}
}
@media screen and (min-width: 501px) {
	.option-input-parameter.print-format-list > input::-ms-input-placeholder {
		color: white;
	}
}
@media screen and (max-width: 400px) {
	.option-input-parameter.print-format-list {
		width: 180px !important;
	}
}
@media screen and (max-width: 320px) {
	.option-input-parameter.print-format-list {
		width: 150px !important;
	}
}
@media screen and (max-width: 500px) {
	.save-parameter-container .saved-parameter-label {
		display: none;
	}
}
@media screen and (min-width: 501px) {
	.save-parameter-container .saved-parameter-list > input::-webkit-input-placeholder {
		color: white;
	}
}
@media screen and (min-width: 501px) {
	.save-parameter-container .saved-parameter-list > input::-moz-placeholder {
		color: white;
	}
}
@media screen and (min-width: 501px) {
	.save-parameter-container .saved-parameter-list > input::-ms-input-placeholder {
		color: white;
	}
}
