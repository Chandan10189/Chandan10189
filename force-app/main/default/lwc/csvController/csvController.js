import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/CsvControllercls.getAccounts'
export default class CsvController extends LightningElement {

    accountData=[]
    @wire(getAccounts)
    accountHandler({data,error}){
        if(data){
            console.log(data)
            this.accountData = data
        }
        if(error){
            console.error(error)
        }
    }

    csvGenerator(){
        
    }
}