<%-- report viewer print format selector samples --%>
.report-format-popup {
	min-width: 360px;
	padding: 6px 0;
}
.report-format-who {
	display: block;
	padding: 2px 12px 6px;
	font-size: 12px;
	color: #6b7280;
}
.report-format-group {
	display: block;
	padding: 8px 12px 4px;
	font-size: 11px;
	font-weight: 600;
	letter-spacing: .05em;
	text-transform: uppercase;
	color: #6b7280;
	border-top: 1px solid #d8dce3;
}
.report-format-row {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 6px 12px;
	cursor: pointer;
}
.report-format-row:hover,
.report-format-row.selected {
	background: rgba(47, 111, 237, .14);
}
.report-format-icon {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 30px;
	height: 30px;
	border: 1px solid #d8dce3;
	border-radius: 6px;
	font-size: 11px;
	color: #6b7280;
	flex: none;
}
.report-format-text {
	flex: 1;
}
.report-format-name {
	display: block;
	font-weight: 600;
}
.report-format-description {
	display: block;
	font-size: 12px;
	color: #6b7280;
}
.report-format-footer {
	display: flex;
	justify-content: space-between;
	padding: 8px 12px 2px;
	border-top: 1px solid #d8dce3;
}
.report-format-action {
	cursor: pointer;
	color: #2f6fed;
}
