/// @author Xiaoyuan Yu
/// @date   2024-05-04
#include "util.h"

#ifdef __linux__
#include <sys/stat.h>
#include <sys/ioctl.h>
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

int open_data_files(FILE **sim_par, FILE **sim_out, const char *data_root)
{
    char date_and_time[40];
    char simulation_data_directory[60];
    char simulation_parameter_path[80];
    char simulation_output_path[80];

    system_time(date_and_time, sizeof(date_and_time));

    sprintf(simulation_data_directory, "%s/%s", data_root, date_and_time);
    sprintf(simulation_parameter_path, "%s/parameter.txt", simulation_data_directory);
    sprintf(simulation_output_path, "%s/output.dat", simulation_data_directory);

    if (create_path(simulation_data_directory)) {
        return 1; // exit when fail to create path
    }

    *sim_par = fopen(simulation_parameter_path, "w");
    if(*sim_par == NULL)
        return 1;

    *sim_out = fopen(simulation_output_path, "w");
    if(*sim_out == NULL)
        return 1;
    
    return 0;
}

unsigned short get_terminal_width()
{
    struct winsize w;
    ioctl(stdout->_fileno, TIOCGWINSZ, &w);
    return w.ws_col;
}

void update_progress_bar(uint64_t current, uint64_t total, const char *s)
{
    size_t progress_bar_width = (size_t)(get_terminal_width() * 0.45 - strlen(s));

    float progress_percent = ((float)current / total) * 100;
    size_t bar_length = (size_t)(progress_percent / 100 * progress_bar_width);

    printf(s);
    putchar('[');
    for (size_t i = 0; i < progress_bar_width; i++)
    {
        if (i < bar_length)
            putchar('=');
        else
            putchar(' ');
    }
    putchar(']');

    if (current == total)
        puts(" Done. ");
    else
        printf(" %.2f%% \r", progress_percent);

    fflush(stdout);
}
