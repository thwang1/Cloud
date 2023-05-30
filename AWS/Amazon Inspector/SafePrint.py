import json
from datetime import datetime

class DateTimeAwareJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            tz = obj.tzname()
            return obj.ctime() + (' {}'.format(tz) if tz else '')
        return super(DateTimeAwareJSONEncoder, self).default(obj)

def printJSON(d):
    return print(json.dumps(d, sort_keys=True, indent=4, cls=DateTimeAwareJSONEncoder))

def getValue(k, d):
    if k in d:
        return d[k]
    return ""
