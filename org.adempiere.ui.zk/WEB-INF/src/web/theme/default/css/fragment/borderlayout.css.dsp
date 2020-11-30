.z-south-splitter,  .z-west-splitter, .z-east-splitter, .z-north-splitter {
	background: none !important;
}
.z-north-splitter, .z-south-splitter {
	height: 14px;
	border: none;
}

.z-south-collapsed, .z-north-collapsed {
	height: 24px;
}

.z-south-collapsed:hover, .z-east-collapsed:hover, .z-west-collapsed:hover, .z-north-collapsed:hover {
	box-shadow:inset 0 0 8px rgba(197,197,197,0.5);
}

.z-south-collapsed .z-borderlayout-icon, .z-north-collapsed .z-borderlayout-icon {
	height: 12px;
	line-height: 12px;
}

.z-west-collapsed {
	cursor: pointer;
	width: 24px;
}

.z-west-collapsed > .z-borderlayout-icon {
	right: 0px;
}

.z-east-collapsed {
	cursor: pointer;
	width: 24px;
}
.z-east-collapsed > .z-borderlayout-icon {
	left: 0px;
}

.z-borderlayout, .z-north, .z-center, .z-south {
	border: none;
}

.z-east-splitter-button,
.z-west-splitter-button,
.z-north-splitter-button,
.z-south-splitter-button {
	filter: alpha(opacity=100);  <%-- IE --%>
	opacity: 1.0;  <%-- Moz + FF --%>
}

.z-east-splitter-button-over,
.z-west-splitter-button-over,
.z-north-splitter-button-over,
.z-south-splitter-button-over {
	-webkit-filter: brightness(50%);
	filter: brightness(50%);
}

.z-north.slide {
	border-bottom: 1px solid #cfcfcf;
	box-shadow: 0px 0px 1px 1px #cfcfcf;
	padding-bottom: 4px;
}
.z-south.slide {
	border-top: 1px solid #cfcfcf;
	box-shadow: 0px 0px 1px 1px #cfcfcf;
	padding-top: 4px;
}
.z-west.slide {
	border-right: 1px solid #cfcfcf;
	box-shadow: 0px 0px 1px 1px #cfcfcf;
	padding-right: 4px;
}
.z-east.slide {
	border-left: 1px solid #cfcfcf;
	box-shadow: 0px 0px 1px 1px #cfcfcf;
	padding-left: 4px;
}