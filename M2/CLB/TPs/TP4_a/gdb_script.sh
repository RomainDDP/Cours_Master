#qemu-system-aarch64 -M raspi3b -kernel ./kernel8.img -serial null -serial stdio -d int -D test.log -gdb tcp::1234 -S &
gdb build/kernel8.elf -x debug.gdb
