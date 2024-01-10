#include <stdio.h>
#include "./Includes/add.h"
#include "./Includes/sub.h"
#include "./Includes/mult.h"
#include "./Includes/div.h"
#include "./Includes/mod.h"

int main() {
    int operation, num1, num2, result;
    
    printf("Enter two numbers: ");
    scanf("%d %d", &num1, &num2);
    
    printf("Select an operation:\n");
    printf("1. Addition\n");
    printf("2. Subtraction\n");
    printf("3. Multiplication\n");
    printf("4. Division\n");
    printf("5. Modulus\n");
    printf("Enter your choice (1-5): ");
    scanf("%d", &operation);
    
    switch (operation) {
        case 1:
            result = add(num1, num2);
            printf("Result: %d\n", result);
            break;
        case 2:
            result = sub(num1, num2);
            printf("Result: %d\n", result);
            break;
        case 3:
            result = mult(num1, num2);
            printf("Result: %d\n", result);
            break;
        case 4:
            if (num2 != 0) {
                result = div(num1, num2);
                printf("Result: %d\n", result);
            } else {
                printf("Error: Division by zero is not allowed.\n");
            }
            break;
        case 5:
            if (num2 != 0) {
                result = mod(num1, num2);
                printf("Result: %d\n", result);
            } else {
                printf("Error: Division by zero is not allowed.\n");
            }
            break;
        default:
            printf("Invalid choice. Please select an operation from 1 to 5.\n");
            break;
    }
    
    return 0;
}
