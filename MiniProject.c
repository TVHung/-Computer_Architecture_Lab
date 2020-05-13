#include <stdio.h>
#include <math.h>

int checkNguyenTo(int n){
	if(n < 2){
        return 0;
    }
    int count = 0;
    for(int i = 2; i <= sqrt(n); i++){
        if(n % i == 0){
            count++;
        }
    }
    if(count == 0){
        return 0;
    }else{
        return 1;
    }
}
 
int main(void) {
	int a, b;
	int soNguyen[100];
	// Printf("Bài toán tìm tất cả số nguyên tố nằm giữa 2 sồ mà người dùng nhập vào");
	// printf("Nhập số thứ nhất: ");
	// scanf("%d", &a);
	// printf("Nhập số thứ hai: ");
	// scanf("%d", &b);
	// int count = 0;
	// for(int i = a ; i <= b ; i++){
	// 	if(checkNguyenTo(i) == 1){
	// 		soNguyen[count] = i;
	// 		count++;
	// 	}
	// }
	// for(int i = 0; i < count; i++){
	// 	printf("%d ", &soNguyen[i]);
	// }
	return 0;
}