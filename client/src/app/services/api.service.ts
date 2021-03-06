import { Injectable } from '@angular/core';
import { Http } from '@angular/http';

import 'rxjs/add/observable/throw'
import 'rxjs/add/operator/catch'
import 'rxjs/add/operator/map'

import { API_URL } from './config';

@Injectable()
export class ApiService {
  private pages: string = `${ API_URL }/pages`;

  constructor(private http: Http) { }

  testAPI() {
    return this.http.get(`${ this.pages }/test`).map(res => res.json());
  }

  uploadPackages(data) {
    return this.http.post(`${ API_URL }/pages/uploadPackagesV2`, data).map(res => res.json());
  }

  getPackages() {
    return this.http.get(`${ API_URL }/pages/getPackages`).map(res => res.json());
  }
}
