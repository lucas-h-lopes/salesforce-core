public with sharing class FruityviceService {

    public static List<FruityviceSuccessResponse> getAllFruits(){
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('callout:FruityviceNC/api/fruit/all');
        
        Http http = new Http();
        HttpResponse res = http.send(req);

        throwExceptionIf4xx(res);

        List<FruityviceSuccessResponse> body = (List<FruityviceSuccessResponse>) Json.deserialize(res.getBody(), List<FruityviceSuccessResponse>.class);
        return body;
    }

    public static FruityviceSuccessResponse getFruitById(Integer id){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:FruityviceNC/api/fruit/' + id);
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(req);

       throwExceptionIf4xx(response);

       return (FruityviceSuccessResponse) Json.deserialize(response.getBody(), FruityviceSuccessResponse.class);
    }

    private static void throwExceptionIf4xx(HttpResponse res){
        if(res.getStatusCode() >= 400 && res.getStatusCode() <= 499){
        FruityviceErrorResponse errorResponse = (FruityviceErrorResponse) JSON.deserialize(res.getBody(), FruityviceErrorResponse.class);
        throw new FruityviceException(errorResponse.error);
    }
}
}