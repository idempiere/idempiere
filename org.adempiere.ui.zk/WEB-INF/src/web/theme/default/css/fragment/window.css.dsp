div.wc-modal, div.wc-modal-none, div.wc-highlighted, div.wc-highlighted-none {
	background-color: white;
}

.z-window-embedded .z-window-content {
	border: none;
}

.z-window-embedded .z-window-header, 
.z-window-embedded .z-window-content {
	background-image: none;
}

.z-modal-mask {
	z-index: 1800 !important;
}
.z-window {
	padding: 0px;
}

.z-window-embedded .z-window-content {
	border: none;
}

.z-window-overlapped .z-window-content,  .z-window-modal .z-window-content, 
.z-window-highlighted .z-window-content, .z-window-embedded .z-window-content {
	border: none;
}

.z-window-header {
	padding: 4px;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
	background-color: #484848;
	border-color: #484848;
}
.z-window-embedded > .z-window-header {
	border-radius: 0px;
	background-color: transparent;
}

.z-window-overlapped, .z-window-popup, .z-window-modal, .z-window-highlighted, 
.embedded-dialog .z-window-embedded
{
	background-color: #fff;
	margin: 0px;
}

.z-window-overlapped .z-window-header,
.z-window-popup .z-window-header,
.z-window-modal .z-window-header,
.z-window-highlighted .z-window-header
{
	color: #fff;
	font-weight: bold;
}

.z-window-header, .z-window-content {
	background-image: none !important;
}

.z-window-modal-shadow, .z-window-overlapped-shadow, .z-window-popup-shadow, .z-window-embedded-shadow, .z-window-highlighted-shadow
{
	border-radius: 0px !important;
}

<%-- dialog --%>
.embedded-dialog {
	position: absolute;
}

.embedded-dialog .z-window-embedded-header {
	color: #fff;
	font-weight: bold;
}

.popup-dialog .z-window-overlapped .z-window-content, .popup-dialog .z-window-highlighted .z-window-content {
	padding: 0px;
	background-color: #f5f5f5;
}
.popup-dialog > .z-window-content, .info-panel > .z-window-content {
	padding: 0px;
	border-bottom-left-radius: 4px;
	border-bottom-right-radius: 4px;
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

.dialog-footer {
	margin-bottom: 0;
	background-color: #f5f5f5;
	border-top: 1px solid #ddd;
	-webkit-box-shadow: inset 0 1px 0 #ffffff;
	-moz-box-shadow: inset 0 1px 0 #ffffff;
	box-shadow: inset 0 1px 0 #ffffff;
}

.btn-ok {
	font-weight: bold;
}

<%-- notification message --%>
.z-notification .z-notification-content {
    width: 400px;
}

.z-notification {
	padding: 3px !important;
}

input[type="checkbox"]:focus
{
 	 outline: #0000ff auto 1px;
	-moz-outline-radius: 3px;
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

.date-picker-container {
	padding-left: 5px;
}

.date-picker-component {
	display: inline-grid;
	min-height: 25px;
	border-radius: 5px;
	margin: 0px 5px 5px 0px !important;
}

.date-picker-component .z-listbox {
	border: none;
}

.date-picker-label {
	font-weight: bold;
	margin: 5px;
}

.recordid-editor {
	display: inline-block;
	position: relative;
}
.recordid-editor .z-toolbarbutton {
	padding: 4px 0px 0px 1px;
    margin: 0px;
    display: inline-block;
    background-image: none;
    position: absolute;
    background-color: #F7F7F7;
    width: 22px;
    height: 24px;
    min-height: 24px;
    right: 0px;
    top: 1px;
    border: 1px solid #CFCFCF;
    border-radius: 0;
}

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

.date-picker-calendar-button {
	position: absolute;
    right: 0px;
    top: 5px;
}
