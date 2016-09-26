#!/usr/bin/python

import time   # For sleeping zzzz...
import subprocess  # To call bash script

try:
  import RPi.GPIO as GPIO
except RuntimeError:
  print("Error importing RPi.GPIO!  Need sudo!!\n")

gpio_state = {
  'low':  GPIO.LOW,
  'high': GPIO.HIGH,
}

pd_state = {
  'down':  GPIO.PUD_DOWN,
  'up':    GPIO.PUD_UP,
}

gpio_func = {
  'input':    GPIO.IN,        # Input
  'output':   GPIO.OUT,       # Output
  'spi':      GPIO.SPI,       # Serial Peripheral Interface
  'i2c':      GPIO.I2C,       # Inter-Integrated Circuit
  'pwm':      GPIO.HARD_PWM,  # Hardware Pulse Width Modulator
  'serial':   GPIO.SERIAL,    # Serial Interface
  'unknown':  GPIO.UNKNOWN,   # Unknown
}

def print_RPi_info():
  out_str = "Print Info about RPi:\n" + str(GPIO.RPI_INFO) + "\n"
  print(out_str)

def print_GPIO_version():
  out_str = "Print Rpi.GPIO version: " + str(GPIO.VERSION)  + "\n"
  print(out_str)

def setup_inputs(gpio_in, pd):
  for x in xrange(0, len(gpio_in)):
    GPIO.setup(gpio_in[x], gpio_func['input'], pd[x])

def main():

  print_RPi_info()
  print_GPIO_version()

  # BCM Numbering (Channel numbers on the Broadcom SOC)
  GPIO.setmode(GPIO.BCM)

  # Disable GPIO warnings (Warnings occur when another script is using GPIO)
  GPIO.setwarnings(False)

  # Map Channels
  gpio_in  = [5]
  pd = [pd_state['down']]

  setup_inputs(gpio_in, pd)

  button_pressed = None

  no = "no"
  yes = "yes"

  while True:

    print("ZZZzzzz...\n")
    button_pressed = GPIO.wait_for_edge(gpio_in[0], GPIO.BOTH, timeout=10000)

    if button_pressed != None:
      print("Button has been pressed!!  Say cheese!\n")
      subprocess.call("./take_pic.sh")
    else:
      print("No button pressed :((\n")
      break

  print("Cleaning up\n")
  GPIO.cleanup()

main()
