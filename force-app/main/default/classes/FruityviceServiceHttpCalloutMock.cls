@isTest
global class FruityviceServiceHttpCalloutMock implements HttpCalloutMock{
   
    private String scenario;
    private Integer fruitId;

    public FruityviceServiceHttpCalloutMock(String scenario, Integer fruitId){
        this.scenario = scenario;
        this.fruitId = fruitId;
    }

    public FruityviceServiceHttpCalloutMock(String scenario){
        this.scenario = scenario;
    }
   
    global HTTPResponse respond(HTTPRequest req) {
       HttpResponse res = new HttpResponse();

       res.setHeader('Content-Type', 'application/json');

       switch on scenario{
        when 'success'{
        if(fruitId == null){
        res.setBody('[{"name": "Persimmon","id": 52,"family": "Ebenaceae","order": "Rosales","genus": "Diospyros","nutritions": {"calories": 81,"fat": 0.0,"sugar": 18.0,"carbohydrates": 18.0, "protein": 0.0}},{"name": "Strawberry","id": 3,"family": "Rosaceae","order": "Rosales","genus": "Fragaria", "nutritions": {"calories": 29,"fat": 0.4,"sugar": 5.4,"carbohydrates": 5.5,"protein": 0.8}}]');
        }else{
        res.setBody('{"name": "Strawberry","id": 3,"family": "Rosaceae","order": "Rosales","genus": "Fragaria", "nutritions": {"calories": 29,"fat": 0.4,"sugar": 5.4,"carbohydrates": 5.5,"protein": 0.8}}');
        }
        res.setStatusCode(200);
        }
        when 'error'{
            res.setBody('{"error": "Not found"}');
            res.setStatusCode(404);
        }
       }
       
        return res;
    }
}