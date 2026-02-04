@isTest
public class FruityviceServiceTest {
    
    @isTest
    static void getAllFruits_whenResponseIsNot200ThrowCustomException(){
        Test.setMock(HttpCalloutMock.class, new FruityviceServiceHttpCalloutMock('error'));

        try{
        FruityviceService.getAllFruits();
        Assert.fail('Não entrou no bloco catch');
        }catch(Exception e){
            Assert.isTrue(e instanceof FruityviceException, 'Não é instância de FruityviceException');
        }
    }

    @isTest
    static void getAllFruits_whenResponseIs200ReturnListObject(){
        Test.setMock(HttpCalloutMock.class, new FruityviceServiceHttpCalloutMock('success'));

        List<FruityviceSuccessResponse> result = FruityviceService.getAllFruits();

        System.assertEquals(2, result.size());

        FruityviceSuccessResponse first = result.get(0);
        System.assertEquals('Persimmon', first.name, 'Name do primeiro item não é "Persimmon"');
        System.assertEquals(52, first.id, 'Id do primeiro item não é "52"');
        System.assertEquals('Ebenaceae', first.family, 'Family do primeiro item não é "Ebenaceae"');
        System.assertEquals('Rosales', first.order, 'Order do primeiro item não é "Rosales"');
        System.assertEquals('Diospyros', first.genus, 'Genus do primeiro item não é "Diospyros"');
        Assert.isNotNull(first.nutritions, 'Nutritions do primeiro não está preenchido');
        System.assertEquals(81, first.nutritions.get('calories'), 'Calories do primeiro item não é "81"');
        System.assertEquals(0.0, first.nutritions.get('fat'), 'Fat do primeiro item não é "0.0"');
        System.assertEquals(18.0, first.nutritions.get('sugar'), 'Sugar do primeiro item não é "18.0"');
        System.assertEquals(18.0, first.nutritions.get('carbohydrates'), 'Carbohydrates do primeiro item não é "18.0"');
        System.assertEquals(0.0, first.nutritions.get('protein'), 'Protein do primeiro item não é "0.0"');

        FruityviceSuccessResponse second = result.get(1);
        System.assertEquals('Strawberry', second.name, 'Name do segundo item não é "Strawberry"');
        System.assertEquals(3, second.id, 'Id do segundo item não é "3"');
        System.assertEquals('Rosaceae', second.family, 'Family do segundo item não é "Rosaceae"');
        System.assertEquals('Rosales', second.order, 'Order do segundo item não é "Rosales"');
        System.assertEquals('Fragaria', second.genus, 'Genus do segundo item não é "Fragaria"');
        Assert.isNotNull(second.nutritions, 'Nutritions do segundo não está preenchido');
        System.assertEquals(29, second.nutritions.get('calories'), 'Calories do segundo item não é "29"');
        System.assertEquals(0.4, second.nutritions.get('fat'), 'Fat do segundo item não é "0.4"');
        System.assertEquals(5.4, second.nutritions.get('sugar'), 'Sugar do segundo item não é "5.4"');
        System.assertEquals(5.5, second.nutritions.get('carbohydrates'), 'Carbohydrates do segundo item não é "5.5"');
        System.assertEquals(0.8, second.nutritions.get('protein'), 'Protein do segundo item não é "0.8"');
    }

    @isTest
    static void getFruitById_whenResponseIsNot200ThrowCustomException(){
        Test.setMock(HttpCalloutMock.class, new FruityviceServiceHttpCalloutMock('error'));

        try{
        FruityviceService.getFruitById(1);
        Assert.fail('Não entrou no bloco catch');
        }catch(Exception e){
            Assert.isTrue(e instanceof FruityviceException, 'Não é instância de FruityviceException');
        }
    }

    @isTest
    static void getFruitById_whenResponseIs200ReturnListObject(){
        Test.setMock(HttpCalloutMock.class, new FruityviceServiceHttpCalloutMock('success', 1));

        FruityviceSuccessResponse result = FruityviceService.getFruitById(1);

        System.assertEquals('Strawberry', result.name, 'Name do retorno não é "Strawberry"');
        System.assertEquals(3, result.id, 'Id do retorno não é "3"');
        System.assertEquals('Rosaceae', result.family, 'Family do retorno não é "Rosaceae"');
        System.assertEquals('Rosales', result.order, 'Order do retorno não é "Rosales"');
        System.assertEquals('Fragaria', result.genus, 'Genus do retorno não é "Fragaria"');
        Assert.isNotNull(result.nutritions, 'Nutritions do retorno não está preenchido');
        System.assertEquals(29, result.nutritions.get('calories'), 'Calories do retorno não é "29"');
        System.assertEquals(0.4, result.nutritions.get('fat'), 'Fat do retorno não é "0.4"');
        System.assertEquals(5.4, result.nutritions.get('sugar'), 'Sugar do retorno não é "5.4"');
        System.assertEquals(5.5, result.nutritions.get('carbohydrates'), 'Carbohydrates do retorno não é "5.5"');
        System.assertEquals(0.8, result.nutritions.get('protein'), 'Protein do retorno não é "0.8"');
    }
}