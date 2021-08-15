function write_dataset(x_train::Matrix, y_train::Matrix, x_test::Matrix, y_test::Matrix, windowsize::String)
    # Train dataset
    open("x_train_"*windowsize*".txt", "w") do io
        print(io, x_train)
    end

    open("y_train_"*windowsize*".txt", "w") do io
        print(io, y_train)
    end

    # Test dataset
    open("x_test_"*windowsize*".txt", "w") do io
        print(io, x_test)
    end

    open("y_test_"*windowsize*".txt", "w") do io
        print(io, y_test)
    end
end