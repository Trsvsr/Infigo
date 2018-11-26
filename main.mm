// Infigo: fixes LaunchDaemons not loading with the EtasonJB and UntetherHomeDepot untethers
// Very hacky: if your untether fails, so does your iOS installation. Whoops :P
// (c) 2018 Trevor Schmitt. I am not responsible for any damages.


#include <spawn.h>
extern char **environ;

//cute little wrapper for a posix_spawn call that launches "/bin/launchctl load (path)"
int spawn(const char *path) {
	pid_t pid;
	int status;
	char *argv[] = {"launchctl", "load", (char *)path, NULL};
	status = posix_spawn(&pid, "/bin/launchctl", NULL, NULL, argv, environ);
	if (status == 0) {
		if (waitpid(pid, &status, 0) != -1) {

		}
		else {
			return -1;
		}
	}
	return 0;
}

int main(int argc, char **argv, char **envp) {
	printf("Spawning LaunchDaemons\n");
	// spawn LaunchDaemons (should be self-explanatory :P)
	if (spawn("/Library/LaunchDaemons/") == 0) {
		printf("LaunchDaemons spawned\n");
	}
	else {
		printf("Failed to spawn LaunchDaemons\n");
	}
	/* to ensure user-installed LaunchDaemons load first, 
	the SpringBoard and backboardd LaunchDaemons are moved to "/Library/ld" 
	and must now be loaded manually */
	spawn("/Library/ld/");
	// load the original CrashHousekeeping executable
	pid_t pid;
	int status;
	char *argv2[] = {"real_CrashHousekeeping", NULL, NULL, NULL};
	status = posix_spawn(&pid, "/usr/libexec/real_CrashHousekeeping", NULL, NULL, argv2, environ);
	if (status == 0) {
		if (waitpid(pid, &status, 0) != -1) {

		}
		else {
			return -1;
		}
	}
	return 0;
}
// vim:ft=objc
