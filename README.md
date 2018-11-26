# Infigo
A package that corrects a major issue within EtasonJB and UntetherHomeDepot that prevents the loading of LaunchDaemons located in /Library/LaunchDaemons

# The underlying issue
For some strange reason, launchctl cannot be ran whilst a boot task (such as rtbuddyd) is running, which is a bit of an issue considering that both of the aforementioned untethers abuse rtbuddyd for persistence. Both untethers do attempt to load the LaunchDaemons but nothing ever happens.

# The "fix?"
To work around this issue, we can replace an unnecessary system executable (in this case: CrashHousekeeping) with our own executable that in turn loads LaunchDaemons from /Library/LaunchDaemons well after rtbuddyd has stopped running, effectively negating the issue minus one "little" caveat

# Uh... caveat?
Yeah, if the bootloop protection contained within both untethers kicks in, you're screwed. The system will try to load our executable (which is unsigned) and will therefore kernel panic then restart, going in an infinite loop. Sorry :P

# Is that likely to happen?
Hopefully not, but no guarantees. You can't say I didn't warn you. Have fun.
