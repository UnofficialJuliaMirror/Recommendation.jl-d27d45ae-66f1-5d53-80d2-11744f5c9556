export Event, DataAccessor
export create_matrix, set_user_attribute, set_item_attribute

type Event
    user::Int
    item::Int
    value::Float64 # e.g. rating, 0/1
end

immutable DataAccessor
    events::Array{Event,1}
    R::AbstractMatrix
    user_attributes::Dict{Int,Any} # user => attributes e.g. vector
    item_attributes::Dict{Int,Any} # item => attributes
end

DataAccessor(events::Array{Event,1}, n_user::Int, n_item::Int) = begin
    R = create_matrix(events, n_user, n_item)
    DataAccessor(events, R, Dict(), Dict())
end

function create_matrix(events::Array{Event,1}, n_user::Int, n_item::Int)
    R = spzeros(n_user, n_item)
    for event in events
        R[event.user, event.item] = event.value
    end
    R
end

function set_user_attribute(da::DataAccessor, user::Int, attribute::AbstractVector)
    da.user_attributes[user] = attribute
end

function set_item_attribute(da::DataAccessor, item::Int, attribute::AbstractVector)
    da.item_attributes[item] = attribute
end