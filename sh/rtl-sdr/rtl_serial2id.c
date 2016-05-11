#include <rtl-sdr.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int help(const char ** argv) {
    printf("Usage: %s [--reassign] serialno\n\n", argv[0]);
    printf("Returns the librtlsdr device index for a connected device with the given\n");
    printf("serial number.  In case of conflict, inactive devices are chosen first.\n\n");
    printf("  --reassign     Assign a new serial number in case of duplicates\n\n");
    return -1;
}

int main(int argc, const char ** argv)
{
  int reassign = 0;
  const char * serialno;
  uint32_t device_count;
  uint32_t index;
  uint32_t first_index = ~0;

  if (argc < 2) return help(argv);

  serialno = argv[1];

  if (strcmp(serialno,"--reassign") == 0) {
    if (argc != 3) return help(argv);
    serialno = argv[2];
    reassign = 1;
  } else {
    if (argc != 2) return help(argv);
  }

  device_count = rtlsdr_get_device_count();
  for (index = 0; index < device_count; ++ index) {
    char test_serial[256];
    rtlsdr_dev_t *dev;
    int r;

    test_serial[0] = 0;
    rtlsdr_get_device_usb_strings(index, NULL, NULL, test_serial);
    if (strcmp(test_serial,serialno) != 0)
      continue;

    /* index has provided serial number */
    if (first_index == ~0) first_index = index;

    r = rtlsdr_open(&dev, index);
    if (r == -6)
      continue;
    if (r >= 0)
      rtlsdr_close(dev);

    if (first_index != index) {
      fprintf(stderr, "Duplicate serial number.\n");

      if (reassign) {
        char new_serialno[256];
        char cmdline[512];
        size_t len;
        size_t pos;
        strncpy(new_serialno, serialno, 256);
        len = strnlen(new_serialno, 256);
  
        /* include numbers only for legibility for now */
        for(pos = len - 1; ;) {
          if (new_serialno[pos] < '0' || new_serialno[pos] > '9') {
            /* non-number entry */
            if (pos == len - 1)
              new_serialno[pos] = '2';
            else
              new_serialno[pos] = '1';
          } else if (new_serialno[pos] < '9') {
            ++ new_serialno[pos];
            memset(&new_serialno[pos+1], len - pos - 1, '0');
          } else if (pos > 0) {
            -- pos;
            continue;
          } else if (len < sizeof(new_serialno)) {
            memmove(&new_serialno[1], &new_serialno[0], len);
            ++ len;
            new_serialno[0] = '1';
          }
          break;
        }

        fprintf(stderr, "Reassigning index %u from '%s' to '%s'.\n", index, serialno, new_serialno);
  
        /* call out to rtl_eeprom to write new serial number */
        snprintf(cmdline, sizeof(cmdline), "echo y | rtl_eeprom -d %u -s %s", index, new_serialno);
        system(cmdline);
      }
    }

    break;
  }

  if (index >= device_count)
    index = first_index;
  if (index >= device_count) {
    fprintf(stderr, "%u connected devices\n", device_count);
    fprintf(stderr, "none have serial '%s'\n", serialno);
    printf("NOT FOUND\n");
    return -2;
  }

  printf("%u\n", index);

  return 0;
}
