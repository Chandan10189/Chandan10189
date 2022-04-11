import { LightningElement,track} from 'lwc';
import AccountId from '@salesforce/schema/Contact.AccountId'
import saveContacts from '@salesforce/apex/ContactCreationController.createContacts';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class ContactRecordInsertion extends LightningElement {
    accountId  = AccountId;
    @track KeyIndex = 0;

    @track accountRecList = [
        {
            LastName : '',
            FirstName : '',
            Type__c: '',
            active__c : '',
            accountId : ''
        }
    ];

    addRow(){
        this.KeyIndex+1;
        this.accountRecList.push(
            {
            LastName : '',
             FirstName : '',
             Type__c: '',
            active__c : '',
            accountId : ''
            }
        );
    }

    changeHandler(event){
          if(event.target.name === 'conLastName'){
              this.accountRecList[event.target.accessKey].LastName = event.target.value;
              console.log('Target Name is'+event.target.name);
              console.log('value is'+event.target.value);
          }

         else if(event.target.name === 'FirstName'){
            this.accountRecList[event.target.accessKey].FirstName = event.target.value;
        }

        else if(event.target.name === 'Volunteer'){
            this.accountRecList[event.target.accessKey].Type__c = event.target.value;
        }

        else if(event.target.name === 'IsActive'){
            this.accountRecList[event.target.accessKey].active__c = event.target.value;
        }

    }

    saveMultipleAccounts(){
        saveContacts({contactList : this.accountRecList}).then(result =>{
            this.message = result;
            this.error = undefined;
            console.log(result);

            if(this.message !== undefined){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title : 'Success',
                        message : 'Contacts Created !! ',
                        variant : 'success'
                    })
                )
            }
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title : 'Error creating records',
                    message : error.body.message,
                    variant : 'error',
                })
            )
        })
           
    }

    removeRow(event){
         if(this.accountRecList.length >1){
             this.accountRecList.splice(event.target.accessKey,1);
             this.KeyIndex-1;
             this.isOpen = false;
         }
         else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title : 'Sorry !! You Cannot Delete the Row !!',
                    message : ' You must have more than one Row in order to perform Deletion ',
                    variant : 'Warning'
                })
            )
         }

    }

    Cancel(){
        //const inputFields = this.template.querySelectorAll('lightning-input')
         //console.log("inputFields are :"+inputFields)
          // if(inputFields){
           //    Array.from(inputFields).forEach(field=>{
                  // field.reset()
                 //  console.log('resetted')
              // })
          // }
          //this.template.querySelector('form').reset();
        this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
      element.value = null;
    }); 

    this.template.querySelector('lightning-input[data-name="active"]').checked = false; 
    }

    value = 'Volunteer';

    get options() {
        return [
            { label: 'Patient', value: 'Patient' },
            { label: 'Donar', value: 'Donar' },
            { label: 'Volunteer', value: 'Volunteer' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
       isOpen = false
    openModal(event){
        this.isOpen = true;
    }

    closeModal(event){
        this.isOpen = false;
    }
}