import { Component, OnInit, Input, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'select-component',
  template: `
    <label for="{{label}}">{{label}}</label>
    <select class="form-control" id="{{label}}" required (change)="optionSelected()" [(ngModel)]="chosenOption">
    <option disabled hidden [value]="placeholder">Select {{label}}</option>
    <option *ngFor="let option of options" [ngValue]="option">{{option.name}}</option>
  `
})

export class SelectComponent implements OnInit {
  @Input() label: string;
  @Input() options: any;
  @Input() default: any;
  @Output() selected = new EventEmitter();

  private chosenOption: any;
  private placeholder: any;

  ngOnInit() {
    this.chosenOption = this.default;
  }
  
  optionSelected() {
    this.selected.emit(this.chosenOption);
  }

  clearSelections(label) {
    var selectElement = document.getElementById(label);
    // The last targeting type option is the default none value
    if(label == 'Targeting Type 1' || label == 'Targeting Type 1' || label == 'Targeting Type 2' || label == 'Targeting Type 3' || label == 'Targeting Type 4'){
      selectElement['value'] = "10: Object";
    } else {
      selectElement['value'] = this.default;
    }
  }

  setSelections(label) {
    var selectElement = document.getElementById(label);
    selectElement['value'] = this.default;
  }

}