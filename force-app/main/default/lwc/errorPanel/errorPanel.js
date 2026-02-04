import { LightningElement, api } from 'lwc';

export default class ErrorPanel extends LightningElement {

    @api error;

    showDetailedMessage = false;
    iconName = 'utility:chevrondown';

    handleClick(){
        this.showDetailedMessage = !this.showDetailedMessage;
        this.iconName = this.iconName == 'utility:chevrondown' ? 'utility:chevronup' : 'utility:chevrondown';
    }

    userFriendlyMessage = 'Erro ao resgatar dados'

    connectedCallback(){
        if (this.error == null){
            throw new Error('Param: Error is required');
        }
    }
}