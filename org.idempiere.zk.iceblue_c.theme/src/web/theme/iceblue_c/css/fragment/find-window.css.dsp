.find-window-simple .z-south .z-hbox, .find-window-advanced .z-south .z-hbox {
	margin-top: 5px;
}

.find-window-simple .img-btn, .find-window-simple .img-btn.btn-ok.z-button, .find-window-simple .img-btn.btn-cancel.z-button,
.find-window-advanced .img-btn, .find-window-advanced .img-btn.btn-ok.z-button, .find-window-advanced .img-btn.btn-cancel.z-button {
	margin: 0 2px;
}

.find-window .z-window-content {
	padding-bottom: 0px;	
}
.find-window .z-grid.z-flex-item,
.find-window .z-listbox.z-flex-item,
.find-window .z-toolbar,
.find-window .z-south-body>.z-hbox {
	width: calc(100% - 1px);
}
.find-window .z-toolbar {
	border-bottom: 0px;
}

/* Modern Popup Container */
.modern-popup-container {
    background: #ffffff;
    border: none;
    padding: 0;
    margin: 0;
    border-radius: 4px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
    min-width: 240px;
    overflow: hidden;
    backdrop-filter: blur(10px);
}

/* Mobile-specific styling */
@media (max-width: 768px) {
    .modern-popup-container {
        min-width: 280px;
        max-width: 90vw;
	    border-radius: 4px;
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
    }
}

@media (max-width: 480px) {
    .modern-popup-container {
        min-width: 320px;
        max-width: 95vw;
	    border-radius: 4px;
    }
}

/* Fix for ZK Popup content padding - only for modern popups */
.modern-popup.z-popup .z-popup-content {
    padding: 0 !important;
    border: none !important;
    background: transparent !important;
}

/* Modern Checkbox Items */
.modern-checkbox-item {
    padding: 14px 18px;
    margin: 0;
    font-size: 14px;
    color: #2c3e50;
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: pointer;
    width: 100%;
    box-sizing: border-box;
    font-weight: 500;
    letter-spacing: 0.3px;
    display: flex;
    align-items: center;
    border: none;
    background: transparent;
    min-height: 44px; /* Minimum touch target size */
}

/* Mobile-specific checkbox styling */
@media (max-width: 768px) {
    .modern-checkbox-item {
        padding: 16px 20px;
        font-size: 16px;
        min-height: 48px;
        letter-spacing: 0.2px;
    }
}

@media (max-width: 480px) {
    .modern-checkbox-item {
        padding: 18px 22px;
        font-size: 16px;
        min-height: 52px;
        font-weight: 400;
    }
}

/* Touch-friendly hover effects for mobile */
@media (max-width: 768px) {
    .modern-checkbox-item:hover,
    .modern-menu-item:hover {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        transform: none; /* Remove transform on mobile for better performance */
    }
    
    .modern-menu-delete:hover {
        background: linear-gradient(135deg, #fef2f2 0%, #fecaca 100%);
        transform: none;
    }
    
    /* Add active states for touch feedback */
    .modern-checkbox-item:active,
    .modern-menu-item:active {
        background: #e9ecef;
        transform: none;
    }
    
    .modern-menu-delete:active {
        background: #fecaca;
        transform: none;
    }
}

/* Separator between items */
.modern-checkbox-item:not(:last-child) {
    border-bottom: 1px solid #f1f3f4;
}

/* Modern Menu Item (Button styling) */
.modern-menu-item {
    padding: 14px 18px;
    margin: 0;
    font-size: 14px;
    color: #2c3e50;
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: pointer;
    width: 100%;
    box-sizing: border-box;
    font-weight: 500;
    letter-spacing: 0.3px;
    display: flex;
    align-items: center;
    border: none;
    background: transparent;
    text-align: left;
    outline: none;
    min-height: 44px; /* Minimum touch target size */
}

/* Mobile-specific menu item styling */
@media (max-width: 768px) {
    .modern-menu-item {
        padding: 16px 20px;
        font-size: 16px;
        min-height: 48px;
        letter-spacing: 0.2px;
    }
}

@media (max-width: 480px) {
    .modern-menu-item {
        padding: 18px 22px;
        font-size: 16px;
        min-height: 52px;
        font-weight: 400;
    }
}

.modern-menu-item:hover {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    transform: translateX(2px);
}

.modern-menu-item:active {
    transform: translateX(1px);
    background: #e9ecef;
}

/* Delete button specific styling */
.modern-menu-delete {
    color: #e74c3c;
    font-weight: 600;
}

.modern-menu-delete:hover {
    background: linear-gradient(135deg, #fef2f2 0%, #fecaca 100%);
    color: #dc2626;
}

.modern-menu-delete:active {
    background: #fecaca;
    transform: translateX(1px);
}

/* Modern Separator */
.modern-separator {
    border: none;
    height: 1px;
    background: linear-gradient(90deg, transparent 0%, #dee2e6 50%, transparent 100%);
    margin: 8px 12px;
}

/* Checkbox styling with mobile improvements */
.modern-checkbox-item .z-checkbox-content {
    font-size: 14px;
    font-weight: 500;
    color: inherit;
}

.modern-checkbox-item .z-checkbox {
    margin-right: 12px;
    min-width: 20px;
    min-height: 20px;
}

@media (max-width: 768px) {
    .modern-checkbox-item .z-checkbox-content {
        font-size: 16px;
        font-weight: 400;
    }
    
    .modern-checkbox-item .z-checkbox {
        margin-right: 16px;
        min-width: 24px;
        min-height: 24px;
    }
}

.modern-checkbox-item .z-checkbox-input:checked + .z-checkbox-content::before {
    background: #007bff;
    border-color: #007bff;
}

/* Animation for popup appearance */
.modern-popup-container {
    animation: popupFadeIn 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

@keyframes popupFadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px) scale(0.95);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}