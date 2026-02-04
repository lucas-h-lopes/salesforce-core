public class FruityviceController {
    @AuraEnabled(cacheable=true)
    public static List<FruityviceSuccessResponse> getAllFruits(){
        try{
            return FruityviceService.getAllFruits();
        }catch(FruityviceException e){
            throw new AuraHandledException('Erro desconhecido');
        }
    }

    @AuraEnabled(cacheable=true)
    public static FruityviceSuccessResponse getFruitById(Integer id){
        try{
            return FruityviceService.getFruitById(id);
    }catch(FruityviceException e){
        throw new AuraHandledException('Fruta não encontrada');
    }
}
}