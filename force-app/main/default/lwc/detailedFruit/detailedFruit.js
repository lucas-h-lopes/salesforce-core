import { LightningElement, wire, api } from 'lwc';
import getFruitById from '@salesforce/apex/FruityviceController.getFruitById';

export default class DetailedFruit extends LightningElement {

    @api fruitId;
    isLoading = true;
    fruitData = {}
    error;

    connectedCallback(){
        if(!this.fruitId){
            throw new Error('c-detailed-fruit requer o parâmetro: fruit-id');
        }
    }

    @wire(getFruitById, {id: '$fruitId'})
    wiredFruit({data, error}){
        
        if(data){
            this.fruitData = data;
            this.error = null;
            this.isLoading = false;
            return;
        }
        if(error){
            this.fruitData = {};
            this.error = error;
            this.isLoading = false;
            return;
        }
    }

    get hasFruit(){
        return this.fruitData && this.fruitData.name != null;
    }

    get hasNutrition(){
        return this.fruitData.nutritions != null;
    }

    get name(){
        return this.fruitData.name ? this.fruitData.name : '';
    }

    get family(){
        return this.fruitData.family ? this.fruitData.family : '';
    }

    get order(){
        return this.fruitData.order ? this.fruitData.order : '';
    }

    get genus(){
        return this.fruitData.genus ? this.fruitData.genus : '';
    }

    get calories(){
        if(this.fruitData.nutritions){
        const calories = this.fruitData.nutritions.calories;
        return calories ? calories : '0.0';
        }
    }

    get fat(){
        if(this.fruitData.nutritions){
        const fat = this.fruitData.nutritions.fat;
        return fat ? fat : '0.0';
        }
    }

    get sugar(){
        if(this.fruitData.nutritions){
        const sugar = this.fruitData.nutritions.sugar;
        return sugar ? sugar : '0.0';
        }
    }

    get carbohydrates(){
        if(this.fruitData.nutritions){
        const carbohydrates = this.fruitData.nutritions.carbohydrates;
        return carbohydrates ? carbohydrates : '0.0';
        }
    }

    get protein(){
        if(this.fruitData.nutritions){
        const protein = this.fruitData.nutritions.protein;
        return protein ? protein : '0.0';
        }
    }

}