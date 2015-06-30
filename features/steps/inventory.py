import os, subprocess, re
from behave import *

@given(u'that I have access to basic-test-data-directory')
def step_impl(context):
    assert os.path.isdir("features/test-data")
    context.test_dir_path="features/test-data/basic-testdir"

@when(u'I run inventory on that directory')
def step_impl(context):
    context.output=subprocess.check_output(["./inventory.sh", context.test_dir_path])

@then(u'for each file the <filename> should be listed with the <checksum>')
def step_impl(context):
    for row in context.table:
        ex = '.*' + row['checksum'] + ' ([^\n]* )?' + row['filename']
        p= re.compile( ex, re.DOTALL )
        assert p.match(context.output)

@then(u'"emptydirectory" should not be present')
def step_impl(context):
    ex="emptydirectory"
    p= re.compile( ex, re.DOTALL )
    assert not p.match(context.output)
