trigger AccountTrigger on Account(after insert, before delete) {
  switch on Trigger.operationType {
    when AFTER_INSERT {
    }
    when BEFORE_DELETE {
      for (Account acc : [
        SELECT id, (SELECT id FROM Contacts)
        FROM Account
        WHERE id IN (SELECT accountid FROM Contact) AND id IN :Trigger.old
      ]) {
        Map<Id, Contact> contactMap = new Map<Id, Contact>(acc.Contacts);
        String contactIds = String.join(contactMap.keySet(), ' ');
        Trigger.oldMap.get(acc.id).addError('Uma conta com contatos não pode ser excluída. IDs: ' + contactIds);
      }
    }
  }
}
