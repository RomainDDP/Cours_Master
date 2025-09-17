qemu-system-aarch64 -machine raspi3b -serial null -serial mon:stdio -nographic -kernel ./kernel8.img -gdb tcp::1234 -S &

gdb build/kernel8.elf -x debug.gdb
