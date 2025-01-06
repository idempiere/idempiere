<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>
<%-- breadcrumb --%>
.breadcrumb-toolbar-button, .z-toolbarbutton[disabled] .z-toolbarbutton-content
{
	background-color: transparent;
}
 
.adwindow-form.z-grid > .z-grid-body {
	overflow: visible !important;
}

<%-- main vlayout of AD window --%>
.adwindow-layout {
	position:absolute; 
	border: none;
	width: 100%;
	height: 100%;
}

.adwindow-layout .z-center {
	border: none;
}

<%-- toolbar, breadcrumb and status bar --%>
.adwindow-north {
	min-height: 56px;
	width: 100%;
	padding: 0px;
	margin: 0px;
	border: none;
}

<%-- north status bar --%>
.adwindow-status {
	min-height: 22px;
	padding-top: 3px;
	background-color: #f6fafe;
}

<%-- record info text, east of status bar --%>
.adwindow-status-docinfo {
	display: inline-block;
	position: absolute;
	right: 4px;
	max-width: 90%;
}

.docstatus-error .z-label {
	color: red;
}

<%-- status text, west of status bar --%>
.adwindow-status-docstatus {
	display: inline-block;
	float: left;
	padding-left: 4px;
}

.adwindow-toolbar.mobile {
	position: relative;
	overflow: hidden;
}

.adwindow-breadcrumb {
	min-height: 32px;
	background-color: #FFF;
	padding: 0px;
	padding-left: 5px;
	border-bottom: 1px solid #C5C5C5 !important;
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	justify-content: space-between;
}
.adwindow-breadcrumb-paths {
	display: inline-block;
	padding: 4px 0px;
}
.adwindow-breadcrumb-toolbar {
	display: inline-block; 
	text-align: right;
}
.adwindow-breadcrumb-toolbar .z-toolbarbutton {
	margin-left: 2px;
}
.adwindow-breadcrumb-toolbar .z-toolbar {
	background-image: none; 
	background-color: transparent; 
	border: none;
}
.adwindow-breadcrumb .breadcrumb-record-info.link {
}
.adwindow-breadcrumb .z-toolbarbutton-content {
	line-height: inherit;
}

<%-- dropdown menu icon --%>
.adwindow-breadcrumb-menu::after {
	font-family: FontAwesome;
	font-weight: 900;
    font-style: normal;
	font-size: 12px;
    content: "\f0d7";
    margin-left: 3px;
}

<%-- div container of detail tabbox --%>
.adwindow-detailpane {
	width: 100%; 
	overflow-y: visible;
}

.adwindow-detailpane-tabbox {
	width: 99%; 
	margin: auto;
}
.adwindow-detailpane-tabbox .z-tab-selected span.z-tab-text {
	cursor: pointer;
}
.adwindow-detailpane-tabbox .z-tab-selected span.z-tab-text:hover {
	text-decoration: underline;
}

.adwindow-detailpane-tabpanel {
	background-color: #fff
}

<%-- toolbar of detail panel --%>
.adwindow-detailpane-toolbar {
	border: none;
	height: 2em;
	background: none;
}
.adwindow-detailpane-toolbar .z-toolbar-body {
	width: 100%;
}
.adwindow-detailpane-toolbar .z-toolbarbutton {
	display: inline-flex;
	padding: 0px;
	width: 20px;
	line-height: 14px;
}
.adwindow-detailpane-toolbar .z-toolbarbutton img {
	width: 16px;
	height: 16px;
}
.adwindow-detailpane-toolbar .z-toolbar-body .docstatus-normal,  
.adwindow-detailpane-toolbar .z-toolbar-body .docstatus-error {
	padding-left: 4px;
	margin-top: 2px;
}
.adwindow-detailpane-toolbar .z-toolbar-body .docstatus-normal .z-label,
.adwindow-detailpane-toolbar .z-toolbar-body .docstatus-error .z-label {
	${fontSizeM};
}
.adwindow-detailpane-toolbar .z-toolbarbutton-content {
	line-height: 14px;
	height: 16px;
}

.adwindow-detailpane-message {
	float: right;
}

<%-- south of grid view for record and paging navigation --%>
.adwindow-detailpane-adtab-grid-south {
	background-color: transparent; 
	position: absolute; 
	right: 0px; 
	top: 0px; 
	height: 24px;
}
.adwindow-detailpane-adtab-grid-south .z-paging {
	padding: 0px !important;
	height: 2em;
	border: none;
	background: #ffffff;
}
.adwindow-detailpane-adtab-grid-south .z-paging .z-paging-inp {
	height: 16px;
	line-height: 16px;
}
.z-paging .z-paging-icon {
    font-size: 12px;
    font-weight: normal;
}

<%-- south region of AD tab for detail panel --%>
.adwindow-gridview-detail {
	min-height: 200px;
	height: 35%;
}
.adwindow-gridview-detail .z-south-body {
	padding-top: 1px;
}

<%-- AD tab in detail panel with tab level greater than 0 --%>
.adwindow-detailpane-sub-tab::before {
	content: '';
	position: absolute;
	width: 0px;
	height: 0px;
	top: 6px;
	left: 4px;
	border-top: 5px dashed transparent;
	border-left: 5px dashed #696969;
	border-right: 5px dashed transparent;
	border-bottom: 5px solid transparent;
	margin-top: 4px;
}

<%-- ad tab --%>
.adtab-content {
	margin: 0;
	padding: 0;
	border: none;
	position: relative;
}

.adtab-grid {
	margin-top: -1px;
	border: none !important;
}
.adtab-grid-south {
	border: none;
	height: 30px;
}
.adtab-grid-south .z-paging {
	border: none;
	padding: 0;
}
.adtab-grid .z-checkbox > input[type="checkbox"] {
	font-size: 14px;
	height: 14px;
	width: 14px;
}
.adtab-grid > .z-grid-header > table > tbody > tr.z-columns > th.z-column > .z-column-content {
	text-overflow: ellipsis;	
}

.adtab-form {
	border:none !important;
	margin:0;
	padding:0;
}
<%-- border layout for west tree, center header panel and south detail panel --%>
.adtab-form-borderlayout {
	width: 100%; 
	height: 100%; 
	position: absolute;
}
.adtab-form-borderlayout .z-center-body {
	background-color: #f6fafe;
}

.adtab-form-borderlayout .z-grid-body {
	background-color: #f6fafe;
 }

<%-- title text for collapsed detail panel --%>
.adtab-form-borderlayout .z-south-collapsed:before { 
	content: '${u:cleanAmp(u:getMsg(u:getCtx(), "Detail"))}';
	position: absolute; 
	font-size: 12px; 
	font-weight: bold;
	text-align: center;
	line-height: 12px;
	left: 4px;
	height: 12px;
	top: 4px;
}

@media screen and (max-height: 767px) {
	.adtab-form-borderlayout.mobile.z-borderlayout > div > .z-south-collapsed > .z-borderlayout-icon.z-icon-chevron-up {
		display: none;
	}
	.adtab-form-borderlayout.mobile.z-borderlayout > div > .adwindow-gridview-detail.z-south {
		height: 50% !important;
	}
}
@media screen and (max-height: 600px) {
	.adtab-form-borderlayout.mobile.z-borderlayout > div > .adwindow-gridview-detail.z-south {
		height: 60% !important;
	}
}
@media screen and (max-height: 500px) {
	.adtab-form-borderlayout.mobile.z-borderlayout > div > .adwindow-gridview-detail.z-south {
		height: 70% !important;
	}
}
@media screen and (max-height: 400px) {
	.adtab-form-borderlayout.mobile.z-borderlayout > div > .adwindow-gridview-detail.z-south {
		height: 80% !important;
	}
}

@media screen and (min-width: 600px) {
    /* Tablets and bigger */
	.adwindow-detailpane-adtab-grid-south .z-paging ul>li {
  		display: inline!important;
	}
}

<%-- record info --%>
.activity-card {
	border: 1px solid #d0cdc8;
	border-top-left-radius: 2px;
	border-top-right-radius: 2px;
	border-bottom: 2px solid #d0cdc8;
	border-bottom-left-radius: 4px;
	border-bottom-right-radius: 4px;
	margin-left: 3px;
	margin-right: 3px;
}
.activity-card-spacing {
	margin-top: 8px;
}
.activity-card .help-content {
	font-size: 13px;
	line-height: 1em;
}
.mobile .activity-card .help-content {
	font-size: 16px;
}
.record-info-dialog .record-info-radiogroup {
	padding: 4px 4px 8px 4px;
}
.record-info-dialog .record-info-changelog-table {
	margin-left: 3px;
	margin-right: 3px;
}

@media only screen 
  and (max-device-width: 700px) {
	.mobile .adtab-grid > .z-cell > .z-label {
		white-space: pre-line;
	}	
}
@media only screen 
  and (max-device-width: 700px) {
	.mobile .adtab-grid > .z-grid-header > table > tbody > tr.z-columns > th.z-column > .z-column-content {
		white-space: pre-line;
	}
}

.mobile-overflow-link {
	font-weight: 700; 
	text-decoration: none;
	transition: background 0.8s;
	background-position: center;
}
.mobile-overflow-link:active {
	background-color: #ddd;
  	background-size: 80%;
	transition: background 0s;
}
.adwindow-status-docstatus .z-label.mobile-overflow-link {
	width: 18px;
	cursor: pointer;
	display: inline-block;
}

.slide-right-out {
    animation: slide-right-out 0.3s forwards;
    animation-timing-function: ease-in;
}
@keyframes slide-right-out {
    0% { transform: translateX(0%); }
    100% { transform: translateX(100%); }
}
.slide-right-in {
    animation: slide-right-in 0.3s forwards;
    animation-timing-function: ease-out;
}
@keyframes slide-right-in {
    0% { transform: translateX(-100%); }
    100% { transform: translateX(0%); }
}

.slide-left-out {
    animation: slide-left-out 0.3s forwards;
    animation-timing-function: ease-in;
}
@keyframes slide-left-out {
    0% { transform: translateX(0%); }
    100% { transform: translateX(-100%); }
}
.slide-left-in {
    animation: slide-left-in 0.3s forwards;
    animation-timing-function: ease-out;
}
@keyframes slide-left-in {
    0% { transform: translateX(100%); }
    100% { transform: translateX(0%); }
}

@media only screen 
  and (max-device-width: 700px) {
	.adwindow-detailpane-toolbar .z-paging-button {
		margin-right: 2px;
	}
	.adwindow-detailpane-toolbar .z-paging-input {
		margin-left: 3px;
	}
	.adwindow-detailpane-toolbar .z-paging-text {
		margin-right: 3px;
	}
	.adwindow-detailpane-toolbar {
		padding-left: 0px;
		padding-right: 0px;
	}
}
@media only screen 
  and (max-device-width: 350px) {
 	.adwindow-detailpane-toolbar .z-paging-input {
		width: 30px;
	}
}
  
