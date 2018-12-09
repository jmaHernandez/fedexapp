import { Component, ElementRef, ViewChild, OnInit, AfterViewInit } from '@angular/core';
import { FormGroup,  FormBuilder,  Validators } from '@angular/forms';
import { Router } from '@angular/router';

// Services
import { ApiService } from '../../services/api.service';


declare const $: any;

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit, AfterViewInit {
  form: FormGroup;
  file: File;

  loading: boolean = false;
  showForm: boolean = true;

  json: any[] = [];

  @ViewChild('fileInput') fileInput: ElementRef;

  constructor(private api: ApiService, private fb: FormBuilder, private router: Router) {
    this.createForm();
  }

  ngOnInit() {
    this.json = [
      {
        "tracking_number": "449044304137821",
        "weight": {
          "units": "LB",
          "value": 11.02
        },
        "dimensions": {
          "length": 17.71,
          "width": 9.84,
          "height": 7.87,
          "units": "IN"
        }
      },
      {
        "tracking_number": "149331877648230",
        "weight": {
          "units": "LB",
          "value": 2.20
        },
        "dimensions": {
          "length": 13,
          "width": 9,
          "height": 3,
          "units": "IN"
        }
      }
    ];
  }

  ngAfterViewInit() {
    let jsonFormat = JSON.stringify(this.json, null, 2);
    $('#json').text(jsonFormat);
  }

  createForm() {
    this.form = this.fb.group({
      packages: [ '', Validators.required ]
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

    data.append('packages', this.file);

    this.loading = true;
    this.showForm = false;

    this.api.uploadPackages(data).subscribe(res => {
      this.loading = false;
      this.showForm = true;

      this.router.navigate(['/report']);
    })
  }
}
