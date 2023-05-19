//Input a matrix
#include<stdio.h>

int main() {
    char input[100];
    
    printf("Enter your input: ");
    scanf("%[^\n]s", input); // Read input until a newline character is encountered

    int spaces = 0;
    int endLine = 0;
    int i = 0;

    while (input[i] != '\0') {
        if (input[i] == ' ') {
            spaces++;
        } else if (input[i] == '\n') {
            endLine = 1;
        }
        i++;
    }

    printf("Spaces count: %d\n", spaces);
    printf("End line detected: %s\n", endLine ? "Yes" : "No");

    return 0;
}