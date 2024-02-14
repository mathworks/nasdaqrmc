classdef nasdaqRMC < handle
%NASDAQRMC Nasdaq Risk Modeling for Catastrophes connection.
%   C = NASDAQRMC(USERNAME,PASSWORD,URL) creates a 
%   nasdaqRMC connection object. USERNAME and PASSWORD can 
%   be input as string scalars or character vectors.  URL is the base 
%   endpoint used for data requests and can be input as a string scalar or 
%   character vector. TIMEOUT is the request value in milliseconds and 
%   input as a numeric value. The default value is 200 milliseconds. C is a 
%   nasdaqRMC object.
%
%   For example,
%   
%   c = nasdaqRMC("username","password",""https://mysite.nrmc.nasdaq.com")
%
%   returns
%
%   c = 
%   
%     nasdaqRMC with properties:
%   
%       TimeOut: 200.00
%
%   See also .

%   Copyright 2023-2024 The MathWorks, Inc. 

  properties
    TimeOut
    UserName
  end
  
  properties (Hidden = true)
    DebugModeValue
    MediaType
    URL   
  end
  
  properties (Access = 'private')
    Password
    Token 
  end
  
  methods (Access = 'public')
  
      function c = nasdaqRMC(usern,passw,url,timeout,mediatype,debugmodevalue)
         
        %  Registered barchart users will have an authentication token
        if nargin < 2
          error("Credentials required.");
        end
        
        

        % Create HTTP URL object
        if nargin < 3 || isempty(url)
          error("URL required.")
        end
        HttpURI = matlab.net.URI(url);
        c.URL = HttpURI.EncodedURI;
        
        % Set request timeout value
        if nargin < 4 || isempty(timeout)
          c.TimeOut = 200;
        else
          c.TimeOut = timeout;
        end

        % Specify HTTP media type i.e. application content to deal with
        if nargin < 5 || isempty(mediatype)
          HttpMediaType = matlab.net.http.MediaType("application/json; charset=UTF-8");
        else
          HttpMediaType = matlab.net.http.MediaType(mediatype);
        end
        c.MediaType = string(HttpMediaType.MediaInfo);

        % Set http request debug value
        if nargin < 6 || isempty(debugmodevalue)
          c.DebugModeValue = 0;
        else
          c.DebugModeValue = debugmodevalue;
        end
        
        % Generate token
        method = "POST";
        authURL = strcat(c.URL,"/keycloak/auth/realms/nrmc/protocol/openid-connect/token");
        
        % Create request object
        HttpURI = matlab.net.URI(authURL);
        HttpHeader = matlab.net.http.HeaderField("Content-Type","application/x-www-form-urlencoded");
        RequestMethod = matlab.net.http.RequestMethod(method);

        % Set options
        options = matlab.net.http.HTTPOptions("ConnectTimeout",c.TimeOut, ...
                                      "DataTimeout",c.TimeOut, ...
                                      "Debug",c.DebugModeValue, ...
                                      "ResponseTimeout",c.TimeOut);
        
        HttpBody = matlab.net.http.MessageBody();
        HttpBody.Payload = strcat("grant_type=password&scope=openid&client_id=mapi&username=",usern,"&password=",passw);
        Request = matlab.net.http.RequestMessage(RequestMethod,HttpHeader,HttpBody);

        % Send request to authenticate token
        response = send(Request,HttpURI,options);

        % Check for response error
        if response.StatusCode ~= 200
          error(string(response.StatusLine))
        end

        % Store information in object
        c.UserName = string(usern);
        c.Password = string(passw);
        c.Token = string(response.Body.Data.access_token);

      end

      function [data,response] = makeRequest(c,httpMethod, endPointPath, jsonParams, varargin)
      %MAKEREQUEST nasdaqRMC request function.
      %   [DATA,RESPONSE} = MAKEREQUEST(C,HTTPMETHOD,ENDPOINTURL,JSONPARAMS,VARARGIN)
      %   requests Nasdaq RMC data given the connection object, C, type of
      %   http request, HTTPMETHOD, the REST API endpoint, ENDPOINTURL, and
      %   a JSON string with the request body for POST requests.  VARARGIN is used
      %   for additional request fields.
      % 
      %   DATA is returned as a table and RESPONSE as a 
      %   matlab.net.http.ResponseMessage object.

        HttpURI = matlab.net.URI(strcat(c.URL,endPointPath));
        HttpHeader = matlab.net.http.HeaderField("accept","*/*","Authorization",['Bearer ' char(c.Token)],"Content-Type",c.MediaType);
        RequestMethod = matlab.net.http.RequestMethod(httpMethod);

        % Create the request message
        switch lower(httpMethod)

          case {'get','put'}
            
            Request = matlab.net.http.RequestMessage(RequestMethod,HttpHeader);
            
          case 'post'
            
            HttpBody = matlab.net.http.MessageBody();
            % Create HttpBody from JSON string or additional request input fields
            if nargin < 5
              HttpBody.Payload = jsonParams;
            else
              HttpBody = matlab.net.http.io.MultipartFormProvider(varargin{:});
            end

            Request = matlab.net.http.RequestMessage(RequestMethod,HttpHeader,HttpBody);

          case 'delete'

            if exist("jsonParams","var") && ~isempty(jsonParams)

              HttpBody.Payload = jsonParams;
              Request = matlab.net.http.RequestMessage(RequestMethod,HttpHeader,HttpBody);

            else

              Request = matlab.net.http.RequestMessage(RequestMethod,HttpHeader);

            end


        end

        % Set options
        options = matlab.net.http.HTTPOptions('ConnectTimeout',c.TimeOut,'Debug',c.DebugModeValue);

        % Send Request
        response = send(Request,HttpURI,options);

        % Convert output Body Data to table
        if isempty(response.Body.Data)
          data = [];
        else
          try
            if istable(response.Body.Data)
              data = response.Body.Data;
            else
              data = struct2table(response.Body.Data,"AsArray",true);
            end
          catch
            data = response;
          end
        end

      end

  end

end