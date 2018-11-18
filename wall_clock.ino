#include <Adafruit_NeoPixel.h>
#include <Wire.h>
#include "RTClib.h"

#define PIN (6)

RTC_DS3231 rtc;

Adafruit_NeoPixel strip = Adafruit_NeoPixel(58, PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  // Setup the LED strip and RTC module.
  strip.begin();
  strip.show();
  rtc.begin();
}

void loop() {
  // Cycle the clock digits through rainbow colors.
  rainbowCycle(100);
}

/* (Methods to un-set certain LEDs to form 7-segment digits.) */

void unsetTimeDigits() {
  DateTime now = rtc.now();
  flip_digits(now.hour() / 10, now.hour() % 10, now.minute() / 10, now.minute() % 10);
}

void flip_digits(int d1, int d2, int d3, int d4) {
  // First digit.
  flip_digit(0, d1);
  // Second digit.
  flip_digit(14, d2);
  // Third digit.
  flip_digit(30, d3);
  // Fourth digit.
  flip_digit(44, d4);
}

// Pattern goes:
// center[0/1] -> top-right[2/3] -> top[4/5] -> top-left[6/7] ->
// bottom-left[8/9] -> bottom[10/11] -> bottom-right[12/13]
void flip_digit(int first_led, int val) {
  if (val == 0) {
    strip.setPixelColor(first_led, 0);
    strip.setPixelColor(first_led + 1, 0);
  }
  else if (val == 1) {
    strip.setPixelColor(first_led, 0);
    strip.setPixelColor(first_led + 1, 0);
    strip.setPixelColor(first_led + 4, 0);
    strip.setPixelColor(first_led + 5, 0);
    strip.setPixelColor(first_led + 6, 0);
    strip.setPixelColor(first_led + 7, 0);
    strip.setPixelColor(first_led + 8, 0);
    strip.setPixelColor(first_led + 9, 0);
    strip.setPixelColor(first_led + 10, 0);
    strip.setPixelColor(first_led + 11, 0);
  }
  else if (val == 2) {
    strip.setPixelColor(first_led + 6, 0);
    strip.setPixelColor(first_led + 7, 0);
    strip.setPixelColor(first_led + 12, 0);
    strip.setPixelColor(first_led + 13, 0);
  }
  else if (val == 3) {
    strip.setPixelColor(first_led + 6, 0);
    strip.setPixelColor(first_led + 7, 0);
    strip.setPixelColor(first_led + 8, 0);
    strip.setPixelColor(first_led + 9, 0);
  }
  else if (val == 4) {
    strip.setPixelColor(first_led + 4, 0);
    strip.setPixelColor(first_led + 5, 0);
    strip.setPixelColor(first_led + 8, 0);
    strip.setPixelColor(first_led + 9, 0);
    strip.setPixelColor(first_led + 10, 0);
    strip.setPixelColor(first_led + 11, 0);
  }
  else if (val == 5) {
    strip.setPixelColor(first_led + 2, 0);
    strip.setPixelColor(first_led + 3, 0);
    strip.setPixelColor(first_led + 8, 0);
    strip.setPixelColor(first_led + 9, 0);
  }
  else if (val == 6) {
    strip.setPixelColor(first_led + 2, 0);
    strip.setPixelColor(first_led + 3, 0);
  }
  else if (val == 7) {
    strip.setPixelColor(first_led, 0);
    strip.setPixelColor(first_led + 1, 0);
    strip.setPixelColor(first_led + 6, 0);
    strip.setPixelColor(first_led + 7, 0);
    strip.setPixelColor(first_led + 8, 0);
    strip.setPixelColor(first_led + 9, 0);
    strip.setPixelColor(first_led + 10, 0);
    strip.setPixelColor(first_led + 11, 0);
  }
  else if (val == 8) {
    // lol
  }
  else if (val == 9) {
    strip.setPixelColor(first_led + 8, 0);
    strip.setPixelColor(first_led + 9, 0);
  }
}

/* LED strand methods from Adafruit's "strand test" example.
 * You can use whatever colors you want, though. */

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if (WheelPos < 85) {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if (WheelPos < 170) {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}

// 'Rainbow' patterns from the Adafruit strandtest example.
void rainbow(uint8_t wait) {
  uint16_t i, j;

  for (j = 0; j < 256; j++) {
    for (i = 0; i < strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel((i + j) & 255));
    }
    unsetTimeDigits();
    strip.show();
    delay(wait);
  }
}

// Slightly different, this makes the rainbow equally distributed throughout
void rainbowCycle(uint8_t wait) {
  int32_t i, j;

  for (j = 256 * 6; j >= 0; --j) { // 5 cycles of all colors on wheel
    for (i = 0; i < strip.numPixels(); i+=2) {
      strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels()) + j) & 255));
      strip.setPixelColor(i+1, Wheel((((i+1) * 256 / strip.numPixels()) + j) & 255));
    }
    unsetTimeDigits();
    strip.show();
    delay(wait);
  }
}
