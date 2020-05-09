#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int checkNguyenTo(int n){
	if(n < 2){
        return 0;
    }
    int count = 0;
    for(int i = 2; i <= n/2 ; i++){
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

void nguyenToGiuaAVaB(){
	int a, b;
	int soNguyen[100];
	int check = 1;
	do{
		printf("Nhập số thứ nhất: ");
		scanf("%d", &a);
		printf("Nhập số thứ hai: ");
		scanf("%d", &b);
		if (a >= b || a <= 0 || b <= 0)
		{
			check = 0;
			printf("Bạn đã nhập sai định dạng! Vui lòng nhập số dương hoặc số thứ nhất phải nhỏ hơn số thứ 2\n");
		}else
		{
			check = 1;
		}
		

	}while (check == 0);
	
	int count = 0;
	for(int i = a ; i <= b ; i++){
		if(checkNguyenTo(i) == 0){
			soNguyen[count] = i;
			count++;
		}
	}
	printf("Các số nguyên tố là: \n");
	for(int i = 0; i < count; i++){
		printf("%d ", soNguyen[i]);
	}
	printf("\n");
}

void menu(){
	printf("-----------------------MEMU-----------------------\n");
	printf("1. Tìm các số nguyên tố trong khoảng từ a đến b\n");
	printf("2. Thoat.\n");

	int choose;
	printf("Mời bạn chọn chức năng [1...2]: ");
	scanf("%d", &choose);

	switch (choose)
	{
	case 1:
		nguyenToGiuaAVaB();
		break;
	
	case 2:
		exit(0);
	default:
		break;
	}
}

int main(void) {
	while (1)
	{
		menu();
	}
	return 0;
}