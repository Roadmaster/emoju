#!/usr/bin/env python2

# Fucking shit this has to work on py2
def read_emoji_from_file(fname):
    """Read an emoji consortium emoji-data.txt into a dict.

    Returns a dict keyed by :shortname: with the value being the actual
    emoji.
    """

    the_dict = {}
    with open(fname, "rb") as emojidata:
        for record in emojidata:
            record = record.decode('utf-8')
            record = record.rstrip()
            if ";" not in record:
                continue
            # Emoji and shortname are everything after # on lines that had ;
            # somewhere
            emoji_shortname = record.split("#", 1)[1]
            # The emoji only is what comes after the first space
            emoji_only = emoji_shortname.split(" ")[1]
            shortname_only = emoji_shortname.split(" ", 2)[2]
            shortname_only = shortname_only.replace(" ", "_")
            shortname_only = shortname_only.replace(
                b'\xe2\x80\x99'.decode('utf-8'), "")
            shortname_only = shortname_only.replace(
                b'\xe2\x80\x9c'.decode('utf-8'), "")
            shortname_only = shortname_only.replace(
                b'\xe2\x80\x9d'.decode('utf-8'), "")
            # Filter out composite emoji
            if len(emoji_only) > 1:
                continue
            the_dict[
                u":{shortcode}:".format(shortcode=shortname_only)] = emoji_only
        return the_dict

ea = read_emoji_from_file("emoji-test.txt")

for short_code in ea.keys():
    print("{!r}".format(short_code))
    print("{}".format(short_code))
