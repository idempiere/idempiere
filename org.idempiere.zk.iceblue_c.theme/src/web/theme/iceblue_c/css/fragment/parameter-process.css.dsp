<%-- process modal dialog --%>
.process-modal-dialog {
	width: 600px;
}
.process-modal-dialog .main-parameter-layout{
	height: auto;
	flex-basis: auto;
}
.process-modal-dialog.z-window > .z-window-content {
	flex: 1 1 auto;
}
@media screen and (max-width: 600px) {
	.process-modal-dialog {
		width: 100%;
	}
}

.main-parameter-layout {
	height: 100%;
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
	display: flex;
    flex-wrap: wrap;
    flex-direction: row;
    align-items: center;
}

.report-option-container div {
    padding: 2px;
}

/* Chromium based browsers + Safari */
@supports (not (-moz-appearance: none)) {
	.report-option-container {
		height: 100% !important;
	}
}

<%-- process/report parameters --%>
.top-parameter-layout{
	overflow: auto;
	padding-bottom: 2vh;
	flex-basis: auto;
}

<%-- run history and action buttons --%>
.bottom-parameter-layout{
	padding: 4px;
	border-top: 1px solid rgba(0, 0, 0, 0.2);
	overflow: visible;
}
.bottom-container{
	overflow: hidden;
}
.save-parameter-container{
	overflow-x: auto;
	overflow-y: hidden;
}
.button-container{
	float: right;
	overflow: hidden;
	padding: 4px;
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

<%-- process help text --%>
.message-parameter{
	max-height: 300pt; 
	overflow: auto; 
	margin: 10px;
	line-height: normal;
}

.message-parameter p {
	margin-bottom: 10px;
}

<%-- execution result panel --%>
.result-parameter-layout {
	overflow: auto;
}

<%-- process parameters --%>
.input-paramenter-layout{
	width: 70%;
	margin-left: 5%;
	margin-right: 25%;
}
@media screen and (max-width: 700px) {
	.input-paramenter-layout{
		width: 90% !important;
		margin-left: 2% !important;
		margin-right: 8% !important;
	}
}
@media screen and (max-width: 500px) {
	.input-paramenter-layout{
		width: 100% !important;
		margin-left: 0 !important;
		margin-right: 0 !important;
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
