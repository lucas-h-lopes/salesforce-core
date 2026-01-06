public with sharing class AccountHandler {
  public static void handleAfterInsert(List<Account> triggerNew) {
    List<Task> taskList = new List<Task>();

    for (Account acc : triggerNew) {
      Task task = new Task(
        OwnerId = UserInfo.getUserId(),
        Status = 'In Progress',
        Subject = 'Call',
        ActivityDate = Date.today().addDays(2),
        WhatId = acc.id,
        Priority = 'Normal'
      );
      taskList.add(task);
    }
    insert taskList;
  }

  public static void handleBeforeInsert(List<Account> triggerNew) {
    for (Account acc : triggerNew) {
      validateAccount(acc);
    }
  }

  public static void handleBeforeDelete(List<Account> triggerOld, Map<Id, Account> triggerOldMap) {
    for (Account acc : [SELECT id, (SELECT id FROM Contacts) FROM Account WHERE id IN (SELECT accountid FROM Contact) AND id IN :triggerOld]) {
      Map<Id, Contact> contactMap = new Map<Id, Contact>(acc.Contacts);
      String contactIds = String.join(contactMap.keySet(), ', ');
      triggerOldMap.get(acc.id).addError('Uma conta com contatos não pode ser excluída. IDs: ' + contactIds);
    }
  }

  private static void validateAccount(Account acc) {
    if (acc.Phone == null) {
      acc.addError('Phone', 'O telefone é obrigatório.');
    }
  }
}
