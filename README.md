# Getting Started with Nasdaq Risk Modelling for Catastrophes in MATLAB&reg;

## Description

This interface allows users to access Nasdaq Risk Modelling for Catastrophes directly from MATLAB.  Nasdaq Risk Modelling for Catastrophes is an independent multi-vendor catastrophe risk modelling platform for insurance companies, reinsurance companies and brokers.

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=mathworks/nasdaqRMC)
## System Requirements

- MATLAB R2022a or later

## Features

Users can retrieve Nasdaq Risk Modelling for Catastrophes data directly from MATLAB.   More information can be found here:

https://www.nasdaq.com/solutions/marketplace-technology/nasdaq-risk-modelling-for-catastrophes

A valid API connection is required for all requests.  Users can retrieve information required to make subsequent data requests given an URL endpoint and additional request parameters.

## Create a Nasdaq Risk Modelling for Catastrophes connection.

```MATLAB
conn = nasdaqRMC("username","password","https://mysite.nrmc.nasdaq.com");
```

## Submit and retrieve information for analysis-controller

```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1");   
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/run-log-files");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/run-log-files/zip");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/run-log-files/file/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/run-log-files/file-zip/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/output-files");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/output-files/zip");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/output-files/file/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/output-files/file-zip/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/output-files/export/1,errors");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/key-errors");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/interim-files");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/interim-files/zip");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/interim-files/file/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/interim-files/file-zip/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/input-files/zip");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/exposure-summary");

httpMethod = "POST";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/setting",'{"staged": true}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/status",'[1]');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/multiple-zip",'{"ids: [1]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/list",'{"ids": [1]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/filter-list",'{"ids": [1],"start": 0,"end": 0,"name": "PiWind Test"}');

httpMethod = "PUT";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/start");   
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/stop");

httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/1/delete");   
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/analysis/delete","[1]");
```
## Submit and retrieve information for batch-controller

```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/preset");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/1/output-files/zip");

httpMethod = "POST";
 [data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/create",'{"name": "Test Batch", "tagIds": [0], "analysisIds": [0]}');
 [data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/1/update",'{"name": "Test Batch", "tagIds": [1], "analysisIds": [1]}');
 [data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/preset",'{"name": "Test Batch", "presetIds": [1], "tagIds": [1]}');
 [data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/preset/generate",'{"name": "Test Batch", "portfolioId": 0, "currency": "USD", "batchPresetId": 0, "tagIds": [1]}');
 [data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/preset/generateMultiPortfolio",'{"name": "Test Batch","portfolioDataPairs": [{"id": 0,"currency": "string"}],"batchPresetId": 0,"tagIds": [0]}');
 [data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/list",'{"ids": [1]}');

httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/1/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/preset/1");  
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/delete");  

httpMethod = "PUT";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/1/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/1/start");  
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/batch/preset/1");  
```
## Submit and retrieve information for tag-controller

```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/list");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/1");

httpMethod = "POST";
[data,response] = makeRequest(conn,httpMethod,strcat("/mapi/v2/tag/","create"),'{"name": "Test Tag"}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/1/update",'{"name": "Test Tag"}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/1/add-to-resource",'{"type": "EXPOSURE_FILE", "resourceId": 0}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/resource/EXPOSURE_FILE/1/set-tags",'{"tagIds": [1]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/list-resources",'{"tagIds": [1],"resourceType": "EXPOSURE_FILE"}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/get-tagged-objects",'[{"type": "EXPOSURE_FILE", "resourceId": 0, "username": "cgarvin"}]');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/filter-list",'{"name": "Test Tag", "resourceTypes": ["EXPOSURE_FILE"], "resourceIds": [0]}');

httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/resource/EXPOSURE_FILE/0/delete-all-tags");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/tag/1/delete-from-resource",'{"type": "EXPOSURE_FILE", "resourceId": 0}');
```
## Submit and retrieve information for return-period-controller

```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/return-period/1");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/return-period/");

httpMethod = "POST";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/return-period/create",'{"name": "TestReturnPeriod","returnPeriods": [1]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/return-period/1/update",'{"name": "TestReturnPeriod","returnPeriods": [2]}');

httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/return-period/1");
```

## Submit and retrieve information for preset-controller
```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/preset/0");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/preset/list");

httpMethod = "POST";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/preset/create",'{"name": "TestPresetController","type": "FULL"}');
[dataPreset,response] = makeRequest(conn,httpMethod,"/mapi/v2/preset/0/update",'{"name": "TestReturnPeriodUpdated","type": "FULL"}');

httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/preset/0/delete");
```

## Submit and retrieve information for portfolio-controller
```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/portfolio/0/header-fields");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/portfolio/0/errors");

httpMethod = "POST";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/portfolio/create",'{"name": "Test Portfolio","fileIds": [0],"exchangeRateTableId": 0,"currencies": ["USD"],"tagIds": [0]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/portfolio/0/update",'{"name": "Test Portfolio Update"}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/portfolio/","/list",'{"ids": [0]}');

httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/portfolio/0/delete");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/portfolio/delete");
```

## Submit and retrieve information for model-controller
```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/0/defaultPresets");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/0/docs");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/0/docs/modelName");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/0/listDefaultPresets");

httpMethod = "POST";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/0/defaultPresets",'{"modelId": 0,"defaultAnalysisPresetId": 0,"defaultReportingPresetId": 0,"forced": true}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/validateSettings",'{{"modelId": 0,"portfolioId": 0,"settings": {"additionalProp1": {},"additionalProp2": {},"additionalProp3": {}}}}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/list",'{"ids": [0]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/listVendors",'[{"id": 0,"supplierId": "0","name": "supplierName","description": "supplierDescription"}]');
          
httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/model/0/defaultPresets");
```

## Submit and retrieve information for exposure-file-controller
```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/0");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/0?numberOfLines=10");

httpMethod = "POST";
conn.MediaType = "multipart/form-data";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/upload","","file","i:\nasdaqRMC\PiWind_Loc.csv","type","text/csv");

conn.MediaType = "application/json; charset=UTF-8";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/rename",'{"fileId": 0,"name": "string"}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/list",'{"ids": [0],"onlyValid": true,"type": "ACCOUNT","status": "NEW","oedVersions": ["string"]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/errors",'{"fileId": 0}');
 
 httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/0");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/file-manager/delete");
```

## Submit and retrieve information for exchange-rate-controller
```MATLAB
httpMethod = "GET";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/exchange-rate/0");
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/exchange-rate/");

httpMethod = "POST";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/exchange-rate/create",'{"name": "exchangeRateController","exchangeRates": [{"currency": "string","exchangeRate": 0}]}');
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/exchange-rate/0/update",'{"id": 0,"name": "string","exchangeRates": [{"currency": "USD","exchangeRate": 0}]}');
          
httpMethod = "DELETE";
[data,response] = makeRequest(conn,httpMethod,"/mapi/v2/exchange-rate/0");  
```

## License

The license is available in the LICENSE.TXT file in this GitHub repository.

Community Support

MATLAB Central

Copyright 2024 The MathWorks, Inc.