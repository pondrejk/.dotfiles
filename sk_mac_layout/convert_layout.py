#!/usr/bin/env python3
"""Convert XKB Slovak layout to macOS keylayout format"""

# XKB symbol to macOS key code mapping
# Based on standard ANSI keyboard layout
xkb_to_macos = {
    # Number row
    'TLDE': 50,   # `/~
    'AE01': 18,   # 1/!
    'AE02': 19,   # 2/@
    'AE03': 20,   # 3/#
    'AE04': 21,   # 4/$
    'AE05': 23,   # 5/%
    'AE06': 22,   # 6/^
    'AE07': 26,   # 7/&
    'AE08': 28,   # 8/*
    'AE09': 25,   # 9/(
    'AE10': 29,   # 0/)
    'AE11': 27,   # -/_
    'AE12': 24,   # =/+

    # Top letter row (QWERTY)
    'AD01': 12,   # Q
    'AD02': 13,   # W
    'AD03': 14,   # E
    'AD04': 15,   # R
    'AD05': 17,   # T
    'AD06': 16,   # Y/Z
    'AD07': 32,   # U
    'AD08': 34,   # I
    'AD09': 31,   # O
    'AD10': 35,   # P
    'AD11': 33,   # [/{
    'AD12': 30,   # ]/}

    # Home row (ASDF)
    'AC01': 0,    # A
    'AC02': 1,    # S
    'AC03': 2,    # D
    'AC04': 3,    # F
    'AC05': 5,    # G
    'AC06': 4,    # H
    'AC07': 38,   # J
    'AC08': 40,   # K
    'AC09': 37,   # L
    'AC10': 41,   # ;/:
    'AC11': 39,   # '/"
    'BKSL': 42,   # \/|

    # Bottom letter row (ZXCV)
    'LSGT': 10,   # §/± (extra key on ISO keyboards)
    'AB01': 6,    # Z/Y
    'AB02': 7,    # X
    'AB03': 8,    # C
    'AB04': 9,    # V
    'AB05': 11,   # B
    'AB06': 45,   # N
    'AB07': 46,   # M
    'AB08': 43,   # ,/<
    'AB09': 47,   # ./>
    'AB10': 44,   # //?

    # Space
    'SPCE': 49,
}

# Parse the sk file key definitions
sk_keys = {
    # From sk file basic layout
    'TLDE': ['semicolon', 'dead_abovering', 'grave', 'asciitilde'],
    'AE01': ['plus', '1', 'exclam', 'dead_tilde'],
    'AE02': ['lcaron', '2', 'at', 'dead_caron'],
    'AE03': ['scaron', '3', 'numbersign', 'dead_circumflex'],
    'AE04': ['ccaron', '4', 'dollar', 'dead_breve'],
    'AE05': ['tcaron', '5', 'percent', 'dead_abovering'],
    'AE06': ['zcaron', '6', 'asciicircum', 'dead_ogonek'],
    'AE07': ['yacute', '7', 'ampersand', 'dead_grave'],
    'AE08': ['aacute', '8', 'asterisk', 'dead_abovedot'],
    'AE09': ['iacute', '9', 'braceleft', 'dead_acute'],
    'AE10': ['eacute', '0', 'braceright', 'dead_doubleacute'],
    'AE11': ['equal', 'percent', 'NoSymbol', 'dead_diaeresis'],
    'AE12': ['dead_acute', 'dead_caron', 'dead_macron', 'dead_cedilla'],

    'AD01': ['q', 'Q', 'backslash', 'NoSymbol'],
    'AD02': ['w', 'W', 'bar', 'NoSymbol'],
    'AD03': ['e', 'E', 'EuroSign', 'NoSymbol'],
    'AD04': ['r', 'R', 'NoSymbol', 'NoSymbol'],
    'AD05': ['t', 'T', 'NoSymbol', 'NoSymbol'],
    'AD06': ['z', 'Z', 'NoSymbol', 'NoSymbol'],
    'AD07': ['u', 'U', 'NoSymbol', 'NoSymbol'],
    'AD08': ['i', 'I', 'NoSymbol', 'NoSymbol'],
    'AD09': ['o', 'O', 'NoSymbol', 'NoSymbol'],
    'AD10': ['p', 'P', 'NoSymbol', 'NoSymbol'],
    'AD11': ['uacute', 'slash', 'bracketleft', 'division'],
    'AD12': ['adiaeresis', 'parenleft', 'bracketright', 'multiply'],

    'AC01': ['a', 'A', 'asciitilde', 'NoSymbol'],
    'AC02': ['s', 'S', 'dstroke', 'NoSymbol'],
    'AC03': ['d', 'D', 'Dstroke', 'NoSymbol'],
    'AC04': ['f', 'F', 'bracketleft', 'NoSymbol'],
    'AC05': ['g', 'G', 'bracketright', 'NoSymbol'],
    'AC06': ['h', 'H', 'grave', 'NoSymbol'],
    'AC07': ['j', 'J', 'apostrophe', 'NoSymbol'],
    'AC08': ['k', 'K', 'lstroke', 'NoSymbol'],
    'AC09': ['l', 'L', 'Lstroke', 'NoSymbol'],
    'AC10': ['ocircumflex', 'quotedbl', 'dollar', 'NoSymbol'],
    'AC11': ['section', 'exclam', 'apostrophe', 'ssharp'],
    'BKSL': ['ncaron', 'parenright', 'backslash', 'bar'],

    'LSGT': ['backslash', 'bar', 'slash', 'NoSymbol'],
    'AB01': ['y', 'Y', 'degree', 'NoSymbol'],
    'AB02': ['x', 'X', 'numbersign', 'NoSymbol'],
    'AB03': ['c', 'C', 'ampersand', 'NoSymbol'],
    'AB04': ['v', 'V', 'at', 'NoSymbol'],
    'AB05': ['b', 'B', 'braceleft', 'NoSymbol'],
    'AB06': ['n', 'N', 'braceright', 'NoSymbol'],
    'AB07': ['m', 'M', 'asciicircum', 'NoSymbol'],
    'AB08': ['comma', 'question', 'less', 'NoSymbol'],
    'AB09': ['period', 'colon', 'greater', 'NoSymbol'],
    'AB10': ['minus', 'underscore', 'asterisk', 'NoSymbol'],

    'SPCE': ['space', 'space', 'nobreakspace', 'nobreakspace'],
}

# Symbol to Unicode/character mapping
symbol_map = {
    # Slovak special characters
    'lcaron': 'ľ', 'Lcaron': 'Ľ',
    'scaron': 'š', 'Scaron': 'Š',
    'ccaron': 'č', 'Ccaron': 'Č',
    'tcaron': 'ť', 'Tcaron': 'Ť',
    'zcaron': 'ž', 'Zcaron': 'Ž',
    'yacute': 'ý', 'Yacute': 'Ý',
    'aacute': 'á', 'Aacute': 'Á',
    'iacute': 'í', 'Iacute': 'Í',
    'eacute': 'é', 'Eacute': 'É',
    'uacute': 'ú', 'Uacute': 'Ú',
    'adiaeresis': 'ä', 'Adiaeresis': 'Ä',
    'ocircumflex': 'ô', 'Ocircumflex': 'Ô',
    'ncaron': 'ň', 'Ncaron': 'Ň',
    'dstroke': 'đ', 'Dstroke': 'Đ',
    'lstroke': 'ł', 'Lstroke': 'Ł',
    'racute': 'ŕ', 'Racute': 'Ŕ',
    'lacute': 'ĺ', 'Lacute': 'Ĺ',
    'dcaron': 'ď', 'Dcaron': 'Ď',
    'ecaron': 'ě', 'Ecaron': 'Ě',
    'rcaron': 'ř', 'Rcaron': 'Ř',
    'uring': 'ů', 'Uring': 'Ů',
    'oacute': 'ó', 'Oacute': 'Ó',

    # Basic symbols
    'semicolon': ';',
    'plus': '+',
    'equal': '=',
    'percent': '%',
    'exclam': '!',
    'at': '@',
    'numbersign': '#',
    'dollar': '$',
    'ampersand': '&',
    'asterisk': '*',
    'braceleft': '{',
    'braceright': '}',
    'bracketleft': '[',
    'bracketright': ']',
    'backslash': '\\',
    'bar': '|',
    'grave': '`',
    'asciitilde': '~',
    'asciicircum': '^',
    'quotedbl': '"',
    'apostrophe': "'",
    'section': '§',
    'parenleft': '(',
    'parenright': ')',
    'slash': '/',
    'comma': ',',
    'period': '.',
    'question': '?',
    'colon': ':',
    'less': '<',
    'greater': '>',
    'minus': '-',
    'underscore': '_',
    'degree': '°',
    'space': ' ',
    'ssharp': 'ß',
    'division': '÷',
    'multiply': '×',
    'EuroSign': '€',
    'nobreakspace': ' ',

    # Dead keys and special cases
    'dead_abovering': '°',  # Simplified
    'dead_tilde': '~',
    'dead_caron': 'ˇ',
    'dead_circumflex': '^',
    'dead_breve': '˘',
    'dead_ogonek': '˛',
    'dead_grave': '`',
    'dead_abovedot': '˙',
    'dead_acute': '´',
    'dead_doubleacute': '˝',
    'dead_diaeresis': '¨',
    'dead_macron': '¯',
    'dead_cedilla': '¸',

    'NoSymbol': '',
}

def symbol_to_output(symbol):
    """Convert XKB symbol to output character"""
    if symbol in symbol_map:
        result = symbol_map[symbol]
        if result:  # Don't return empty strings
            return result
    elif len(symbol) == 1:
        return symbol
    return None

def escape_xml(text):
    """Escape special XML characters"""
    if not text:
        return ''
    text = text.replace('&', '&amp;')
    text = text.replace('<', '&lt;')
    text = text.replace('>', '&gt;')
    text = text.replace('"', '&quot;')
    text = text.replace("'", '&apos;')
    # Convert to XML entity for special chars
    result = []
    for char in text:
        code = ord(char)
        if code < 32 or code > 126:
            result.append(f'&#{code:04X};')
        else:
            result.append(char)
    return ''.join(result)

# Generate keyMap entries
keymaps = {
    0: [],  # Base (no modifiers)
    1: [],  # Shift
    2: [],  # Caps Lock
    3: [],  # Option (AltGr)
    4: [],  # Shift+Option
}

for xkb_key, symbols in sk_keys.items():
    if xkb_key not in xkb_to_macos:
        continue

    code = xkb_to_macos[xkb_key]

    # Map the 4 levels from XKB to macOS keymaps
    # Level 0: base
    # Level 1: shift
    # Level 2: altgr (option)
    # Level 3: shift+altgr (shift+option)

    for level, keymap_idx in [(0, 0), (1, 1), (2, 3), (3, 4)]:
        if level < len(symbols):
            output = symbol_to_output(symbols[level])
            if output is not None:
                keymaps[keymap_idx].append((code, escape_xml(output)))

# Caps lock map - uppercase versions
for xkb_key, symbols in sk_keys.items():
    if xkb_key not in xkb_to_macos:
        continue
    code = xkb_to_macos[xkb_key]
    # Use shift version for caps
    if len(symbols) > 1:
        output = symbol_to_output(symbols[1])
        if output is not None:
            keymaps[2].append((code, escape_xml(output)))

# Generate XML
xml_output = '''<?xml version="1.1" encoding="UTF-8"?>
<!DOCTYPE keyboard SYSTEM "file://localhost/System/Library/DTDs/KeyboardLayout.dtd">
<keyboard group="126" id="-17116" name="Slovak Standard" maxout="1">
    <layouts>
        <layout first="0" last="0" mapSet="138" modifiers="30"/>
    </layouts>
    <modifierMap id="30" defaultIndex="0">
        <keyMapSelect mapIndex="0">
            <modifier keys="command?"/>
            <modifier keys="caps? command"/>
        </keyMapSelect>
        <keyMapSelect mapIndex="1">
            <modifier keys="anyShift caps?"/>
        </keyMapSelect>
        <keyMapSelect mapIndex="2">
            <modifier keys="caps"/>
        </keyMapSelect>
        <keyMapSelect mapIndex="3">
            <modifier keys="anyOption"/>
            <modifier keys="caps option? rightOption command?"/>
            <modifier keys="caps? option? rightOption command"/>
        </keyMapSelect>
        <keyMapSelect mapIndex="4">
            <modifier keys="anyShift caps? anyOption"/>
        </keyMapSelect>
    </modifierMap>
    <keyMapSet id="138">
'''

# Add keymaps
for idx in [0, 1, 2, 3, 4]:
    xml_output += f'        <keyMap index="{idx}">\n'

    # Sort by key code
    for code, output in sorted(keymaps[idx]):
        xml_output += f'            <key code="{code}" output="{output}"/>\n'

    # Add standard keys that don't change
    standard_keys = '''            <key code="36" output="&#x000D;"/>
            <key code="48" output="&#x0009;"/>
            <key code="51" output="&#x0008;"/>
            <key code="52" output="&#x0003;"/>
            <key code="53" output="&#x001B;"/>
            <key code="65" output=","/>
            <key code="66" output="&#x001D;"/>
            <key code="67" output="*"/>
            <key code="69" output="+"/>
            <key code="70" output="&#x001C;"/>
            <key code="71" output="&#x001B;"/>
            <key code="72" output="&#x001F;"/>
            <key code="75" output="/"/>
            <key code="76" output="&#x0003;"/>
            <key code="77" output="&#x001E;"/>
            <key code="78" output="-"/>
            <key code="81" output="="/>
            <key code="82" output="0"/>
            <key code="83" output="1"/>
            <key code="84" output="2"/>
            <key code="85" output="3"/>
            <key code="86" output="4"/>
            <key code="87" output="5"/>
            <key code="88" output="6"/>
            <key code="89" output="7"/>
            <key code="91" output="8"/>
            <key code="92" output="9"/>
            <key code="96" output="&#x0010;"/>
            <key code="97" output="&#x0010;"/>
            <key code="98" output="&#x0010;"/>
            <key code="99" output="&#x0010;"/>
            <key code="100" output="&#x0010;"/>
            <key code="101" output="&#x0010;"/>
            <key code="102" output="&#x0010;"/>
            <key code="103" output="&#x0010;"/>
            <key code="104" output="&#x0010;"/>
            <key code="105" output="&#x0010;"/>
            <key code="106" output="&#x0010;"/>
            <key code="107" output="&#x0010;"/>
            <key code="108" output="&#x0010;"/>
            <key code="109" output="&#x0010;"/>
            <key code="110" output="&#x0010;"/>
            <key code="111" output="&#x0010;"/>
            <key code="112" output="&#x0010;"/>
            <key code="113" output="&#x0010;"/>
            <key code="114" output="&#x0005;"/>
            <key code="115" output="&#x0001;"/>
            <key code="116" output="&#x000B;"/>
            <key code="117" output="&#x007F;"/>
            <key code="118" output="&#x0010;"/>
            <key code="119" output="&#x0004;"/>
            <key code="120" output="&#x0010;"/>
            <key code="121" output="&#x000C;"/>
            <key code="122" output="&#x0010;"/>
            <key code="123" output="&#x001C;"/>
            <key code="124" output="&#x001D;"/>
            <key code="125" output="&#x001F;"/>
            <key code="126" output="&#x001E;"/>
'''
    xml_output += standard_keys
    xml_output += '        </keyMap>\n'

xml_output += '''    </keyMapSet>
</keyboard>
'''

print(xml_output)
