/// @author Xiaoyuan Yu
/// @date   2024-05-04
#include "util.h"

#ifdef __linux__
#include <sys/stat.h>
#include <time.h>
#elif defined(_WIN32)
/// todo windows system operation lib
#endif

int create_directory(const char *path)
{
    struct stat st = {0};

    if (stat(path, &st) == -1)
    {
        if (mkdir(path, 0777) == -1)
        {
            perror("Error creating directory");
            return -1;
        }
    }
    return 0;
}

int create_path(const char *path)
{
    char *temp = strdup(path);
    char *pos = temp;
    int status = 0;

    while (*pos != '\0')
    {
        if (*pos == '/')
        {
            *pos = '\0';
            if (strlen(temp) > 0)
            { // Avoid trying to create root directory
                status = create_directory(temp);
                if (status != 0)
                {
                    free(temp);
                    return -1;
                }
            }
            *pos = '/';
        }
        pos++;
    }
    status = create_directory(temp); // Create the last directory
    free(temp);
    return status;
}

char *system_time(char *buffer, size_t max_size)
{
    time_t now;
    struct tm *tm_info;

    time(&now);
    tm_info = localtime(&now);
    strftime(buffer, max_size, "%Y-%m-%d-%H%M%S", tm_info);

    return buffer;
}

int save_simulation_param(
    FILE *f,
    double duration, 
    uint32_t step_count, 
    double step_duration, 
    double mass, 
    double spr_coef, 
    double dump_coef)
{
    fprintf(f, "Simulation duration(s): %lf\n", duration);
    fprintf(f, "Simulation step count: %d\n", step_count);
    fprintf(f, "Simulation step duration(s): %e\n", step_duration);
    fprintf(f, "Mass(g): %e\n", mass);
    fprintf(f, "Spring coeficient(N/m): %e\n", spr_coef);
    fprintf(f, "Dumping coeficient(N/(m/s)): %e\n", dump_coef);
    return 0;
}


