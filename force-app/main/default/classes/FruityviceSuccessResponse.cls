public class FruityviceSuccessResponse {
    @AuraEnabled
    public String genus;
    
    @AuraEnabled
    public String name;

    @AuraEnabled
    public Integer id;

    @AuraEnabled
    public String family;

    @AuraEnabled
    public String order;

    @AuraEnabled
    public Map<String, Double> nutritions;
}