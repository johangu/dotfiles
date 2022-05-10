autoload -Uz add-zsh-hook

function venv {
	python_version=$1
	set -l python_bin
	venv_name=$(basename $PWD | tr . -)
	venv_path=${XDG_DATA_HOME}/py-venv/$venv_name

	if [ -z "$python_version" ]
	then
		python_bin=$($ASDF_DIR/bin/asdf which python)	
	else
		python_bin=${XDG_LOCAL_HOME}/asdf/installs/python/$python_version/bin/python
	fi

	if [ -d $venv_path ]
	then
		echo "Virtual environment $venv_name already exists"
		return 1
	fi

	if [ ! -e $python_bin ]
	then
		echo "Python version $python_version is not installed."
    printf "Install? [y/N]: "
    if read -q; then
        echo; asdf install python $python_version
		else
			return 1
    fi
	fi

	echo "Creating virtual environment $venv_name"
	$python_bin -m venv $venv_path
	source $venv_path/bin/activate
}

__auto_venv() {
	venv_name=$(basename $PWD | tr . -)
	venv_path=${XDG_DATA_HOME}/py-venv/$venv_name

	if [[ -d $venv_path ]]
	then
		source $venv_path/bin/activate
	elif [[ -v VIRTUAL_ENV ]]
	then
		deactivate
	fi
}

add-zsh-hook chpwd __auto_venv
