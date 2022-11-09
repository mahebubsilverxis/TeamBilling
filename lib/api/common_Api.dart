import 'package:flutter/material.dart';

const mainurl_api_https = 'https://';
const mainurl_api_auth_st_tbl = '.de/';
const mainurl_api_auth_tmbl = '.teambilling.de/';

const api = 'api/';

const token = 'token';
const customers = 'customers';
const connections = 'connections';
const devices = '/devices';

const users = 'users';

// NEW
const gettoken = api + token;
const getcustomers = api + customers;
const getcustomersdevices = api + customers + devices;
const getconnections = api + connections;

const getusers = api + users;
// OLD
//const gettoken = mainurl_api_auth_st_tbl + api +token;
// const getcustomers = mainurl_api_auth_st_tbl + api + customers;
// const getcustomersdevices = mainurl_api_auth_st_tbl + api + customers + devices;
// const getconnections = mainurl_api_auth_st_tbl + api + connections;
