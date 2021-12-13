# Example: Add notification trigger via Add-Notificationtrigger


# Get device Server1 information
PS C:>  get-device -name 'Server1'

Name         Id     Status      Host            Sensors    Group         Probe
----         --     ------      ----            -------    -----         -----
Server1      16592  Up          Server1         14         Client1       VPRTG1


# Get sensor on device
PS C:>  get-device -name 'Server1' | get-sensor -type ping

Name      Id     Device        Group        Probe        Status
----      --     ------        -----        -----        ------
Ping      16593  Server1       Client1      VPRTG1       Up


# Get exist notification trigger on sensor Ping on device
PS C:>  get-device -name 'Server1'  | get-sensor -type ping | get-notificationtrigger

Type      ObjectId SubId Inherited ParentId Latency Condition Threshold Unit       OnNotificationAction
----      -------- ----- --------- -------- ------- --------- --------- ----       --------------------
State     16593    1     True      16591    600     Equals    Down                 Notification email Client1


# Add notification trigger 
# - Trigger type: State Trigger
# - When sensor state is 'Down' for at least '600' seconds, perform 'Notification sms Client1 HO'
PS C:> get-device -name 'Server1' | get-sensor -type ping | Add-NotificationTrigger -Type State -State Down -Latency 600 -OnNotificationAction 'Notification sms Client1 HO'

Type      ObjectId SubId Inherited ParentId Latency Condition Threshold Unit       OnNotificationAction
----      -------- ----- --------- -------- ------- --------- --------- ----       --------------------
State     16593    2     False     16593    600      Equals    Down                 Notification sms Client1 HO


# Verify exist notification trigger 
PS C:> get-device -name 'Server1'  | get-sensor -type ping | get-notificationtrigger
Type      ObjectId SubId Inherited ParentId Latency Condition Threshold Unit       OnNotificationAction
----      -------- ----- --------- -------- ------- --------- --------- ----       --------------------
State     16593    2     False     16593    600     Equals    Down                 Notification sms Client1 HO
State     16593    1     True      16591    600     Equals    Down                 Notification email Client1
