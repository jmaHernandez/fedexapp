import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormGroup,  FormBuilder,  Validators } from '@angular/forms';

declare const $: any;

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  form: FormGroup;
  file: File;

  @ViewChild('fileInput') fileInput: ElementRef;

  constructor(private fb: FormBuilder) {
    this.createForm();
  }

  createForm() {
    this.form = this.fb.group({
      packets: [ '', Validators.required ]
    });
  }

  import(value) {
    const selectedFile = this.fileInput.nativeElement;

    if (selectedFile.files && selectedFile.files[0]) {
      let currentFile = selectedFile.files[0];
      let currentType = currentFile.type;

      if (currentType == 'application/json') {
        this.file = currentFile
      } else {
        alert('El archivo debe ser de tipo JSON');

        return false;
      }
    } else {
      alert('No se ha seleccionado un archivo');

      return false;
    }

    let data: FormData = new FormData();

    data.append('packets', value.packets);

    console.log(data.get('packets'));
  }
}
