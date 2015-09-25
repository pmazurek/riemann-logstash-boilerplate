import logging
import logstash
import random


host = 'localhost'

test_logger = logging.getLogger('python-logstash-logger')
test_logger.setLevel(logging.INFO)
test_logger.addHandler(logstash.TCPLogstashHandler(host, 5043, version=1))

extra = {
    'riemann_metric': {
        'metric': 1.1,
        'service': 'test.service',
        'state': 'ok',
        'ttl': 60
    },
    'tags': 'yolo',
}

for i in range(10000):
    test_logger.info('python-logstash: info', extra=extra)
    test_logger.warning('python-logstash: warning', extra=extra)
    test_logger.error('python-logstash: error', extra=extra)
    test_logger.critical('python-logstash: critical', extra={
        'riemann_metric': {
            'metric': random.random(),
            'service': 'test.service',
            'state': 'ok',
            'ttl': 60
        },
        'tags': 'yolo',
    })
