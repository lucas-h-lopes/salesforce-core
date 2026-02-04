import { LightningElement, wire } from 'lwc';
import getAllFruits from '@salesforce/apex/FruityviceController.getAllFruits';
import { ShowToastEvent} from 'lightning/platformShowToastEvent'; 

export default class LoadFruits extends LightningElement {

    fruitOptions = [];
    selectedFruit = {};
    error;

    @wire(getAllFruits)
    wiredFruits({data, error}){
        if(data){
            this.fruitOptions = data.map(x => {return {label: x.name, value: x.id.toString()}});
            this.error = null;
        }else if (error){
            this.fruitOptions = [];
            this.error = error;
            console.log(error);
        }
    }

    get hasFruits(){
        return this.fruitOptions && this.fruitOptions.length > 0;
    }

    handleChange(event){
        const currentId = event.target.value;
        const result = this.fruitOptions.find(x => x.value == currentId);

        if(!result){
            this.selectedFruit = {};
            return;
        }
        this.selectedFruit = {
            name: result.label,
            id: result.value
        };
    }

    handleClick(){
         if(!this.selectedFruit.name || !this.selectedFruit.id){
            this.dispatchEvent(new ShowToastEvent({title: 'Dados inválidos', message: 'Selecione uma fruta para prosseguir.', variant: 'error'}))
            return;
         }
         this.dispatchEvent(new CustomEvent('selectfruit', {detail: this.selectedFruit.id}));
    }
}