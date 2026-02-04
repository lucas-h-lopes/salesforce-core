import { LightningElement, api } from 'lwc';

export default class Modal extends LightningElement {

    @api title = 'Modal';
    @api isOpen;

    handleCancel(){
        this.dispatchEvent(new CustomEvent('cancel'));
    }

    handleSave(){
        this.dispatchEvent(new CustomEvent('save'));
    }
}