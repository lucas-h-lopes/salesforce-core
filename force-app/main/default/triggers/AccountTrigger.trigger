trigger AccountTrigger on Account(before insert, after insert, before delete) {
  switch on Trigger.operationType {
    when BEFORE_INSERT {
      AccountHandler.handleBeforeInsert(Trigger.new);
    }
    when AFTER_INSERT {
      AccountHandler.handleAfterInsert(Trigger.new);
    }
    when BEFORE_DELETE {
      AccountHandler.handleBeforeDelete(Trigger.old, Trigger.oldMap);
    }
  }
}
