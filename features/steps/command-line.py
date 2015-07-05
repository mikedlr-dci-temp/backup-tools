import tempfile, os, subprocess

@given(u'that I have a target-file that doesn\'t exist')
def step_impl(context):
    td=tempfile.mkdtemp()
    context.temp_file_path=td + "/new_inventory_file"

@when(u'I run inventory on the test data with -o on the directory')
def step_impl(context):
    context.output=subprocess.check_output(["./inventory.sh", "-o", 
                                            context.temp_file_path, context.test_dir_path ])

@then(u'the inventory file should be created')
def step_impl(context):
    assert os.path.isfile(context.temp_file_path)

@given(u'nothing much')
def step_impl(context):
    pass

@when(u'I run inventory with no arguments')
def step_impl(context):
    try: 
        context.check_output=subprocess.check_output(["./inventory.sh"])
        context.check_returncode=0
    except subprocess.CalledProcessError as e:
        context.check_output=e.output
        context.check_returncode=e.returncode

@when(u'I run inventory with two -o arguments')
def step_impl(context):
    try: 
        context.check_output=subprocess.check_output(["./inventory.sh", "-o", "filea", "-o", "fileb"])
        context.check_returncode=0
    except subprocess.CalledProcessError as e:
        context.check_output=e.output
        context.check_returncode=e.returncode

@when(u'I run inventory without -c or --check and with an input file')
def step_impl(context):
    try:
        context.check_output=subprocess.check_output(["./inventory.sh", "-i", "filea", "-c"])
        context.check_returncode=0
    except subprocess.CalledProcessError as e:
        context.check_output=e.output
        context.check_returncode=e.returncode

@when(u'I run inventory with -c and with an output file')
def step_impl(context):
    try:
        context.check_output=subprocess.check_output(["./inventory.sh", "-c", "-o", "filea"])
        context.check_returncode=0
    except subprocess.CalledProcessError as e:
        context.check_output=e.output
        context.check_returncode=e.returncode

@then(u'it should abort with a failure')
def step_impl(context):
    assert ( int(context.check_returncode) and context.check_returncode > 0 )

