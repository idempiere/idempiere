.login-window {
	background-color: #c7e8ff;
}

.login-window .z-window-content {
	background-color: #c7e8ff;
}

.login-box-body {
	width: 720px;
	background-color: white;
	padding: 0px 5px 0px 0px;
	margin: 0;
	text-align: center;
}

.login-box-header {
	background-color: white;
	width: 720px;
	border-radius: 10px 10px 0px 0px;
	padding-left: 30px;
	padding-top: 30px;
	padding-right: 30px;
	box-sizing: border-box;
}

.login-box-header-txt {
	font-weight: bold;
	position: relative;
	display: inline-block;
	text-align: left;
	padding: 10px;
	color: #484848 !important;
	width: 100%;	
	font-size: 1.6em !important;
}

.login-box-header-logo {
	padding-bottom: 25px !important;
}

.login-box-footer {
	height: 130px;
	width: 720px;
	background-color: white;
	border-radius: 0px 0px 10px 10px;
	padding-left: 30px;
  	padding-right: 30px;
  	box-sizing: border-box;
}

.login-box-footer .confirm-panel {
	width: 600px !important;
}

.login-box-footer-pnl {
	width: 604px;
	margin-left: 10px;
	margin-right: 10px;
	padding-top: 60px !important;
}

.login-label {
	color: black;
	text-align: right;
	width: 40%;
	padding: 2px !important;
}

.login-field {
	text-align: left;
	width: 55%;
	padding: 2px !important;
}

.login-field input:not([type="checkbox"]) {
	width: 220px !important;
}

.login-btn {
	padding: 4px 20px !important;
}

.login-east-panel, .login-west-panel {
	width: 380px;
	background-color: #ffffff; 
	position: relative;
	border: none;
}
@media screen and (max-width: 659px) {
	.login-box-body, .login-box-header, .login-box-footer {
		background-image: none;
		width: 90%;
	}
	.login-box-footer .confirm-panel, .login-box-footer-pnl {
		width: 100% !important;
        margin: 0px;
	}
	.login-box-footer {
		padding-left: 10px;
		padding-right: 10px;
    }
	.login-box-header-txt {
		display: none;
	}
}
@media screen and (max-height: 600px) {
	.login-box-header-txt {
		display: none;
	}
	.login-box-body, .login-box-header, .login-box-footer {
		background-image: none;
	}
	.login-box-body {
		padding-bottom: 10px;
	}
	.login-box-header {
		height: 0px;
	}
}
@media screen and (max-device-width: 500px) {
	.login-field input:not([type="checkbox"]) {
		width: 100% !important;
	}
}
@media screen and (max-device-width: 380px) {
	.login-west-panel {
		width: 350px;
	}
}
@media screen and (max-width: 359px) {
	.login-window .z-center > .z-center-body .z-window.z-window-embedded > .z-window-content {
		padding: 5px
	}
}
