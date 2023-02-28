from setuptools import find_namespace_packages, setup

setup(
    name="start-and-stop",
    packages=find_namespace_packages(include=["src.*"], exclude=['tests.*']),
    install_requires=[],
    python_requires=">=3.8",
    version="1.0",
    author="Ippon",
    setup_requires=['lambda_setuptools']
)
