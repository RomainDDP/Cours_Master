#ifndef FAT16
#define FAT16


struct node {};

struct file_t {

	int is_rep;
	char content[255];
};

struct rep_t {

	node* son;
	file_t files[255]
};







#endif // !FAT16



