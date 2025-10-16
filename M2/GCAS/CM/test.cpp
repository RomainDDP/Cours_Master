#include <iostream>
#include <exception>

int main() {


	try {
		std::cout << "Taille de bool en octet : " << sizeof(bool) << std::endl;

	} catch (std::exception e) {
		std::cerr << e.what() << std::endl;
	}

	return 0;
}
